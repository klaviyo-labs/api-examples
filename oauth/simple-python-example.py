import json
from flask import Flask, request, redirect
import webbrowser
import base64
import hashlib
import requests
from dotenv import load_dotenv
import os

# This is a unique identifier for the customer in your system. This may be a user id or an organization id.
customer_id = '1234'

# These are both in-memory data stores for simplicity of the example, but you should use a persistent data store
# like Redis or Postgres.
pkce_data_store = {}
token_data_store = {}

KLAVIYO_AUTHORIZATION_URL = "https://www.klaviyo.com/oauth/authorize"
KLAVIYO_TOKEN_URL = "https://a.klaviyo.com/oauth/token"

# OAuth info
load_dotenv()
client_id = os.getenv("CLIENT_ID")
client_secret = os.getenv("CLIENT_SECRET")

# Make sure that you add your redirect uri and new scopes this in your Klaviyo app settings as well.
redirect_uri = 'http://localhost:5001/oauth/klaviyo/callback'
scope = 'list:read list:write campaigns:write metrics:read'

app = Flask(__name__)


def generate_code_challenge():
    verifier_bytes = os.urandom(32)
    code_verifier = base64.urlsafe_b64encode(verifier_bytes).rstrip(b'=').decode('utf-8')
    challenge_bytes = hashlib.sha256(code_verifier.encode()).digest()
    code_challenge = base64.urlsafe_b64encode(challenge_bytes).rstrip(b'=').decode('utf-8')
    return code_verifier, code_challenge


def get_basic_authorization_header():
    return 'Basic ' + base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()


@app.route('/oauth/klaviyo/authorize')
def authorize():
    code_verifier, code_challenge = generate_code_challenge()

    # Store code_verifier in datastore for later use
    pkce_data_store.update({customer_id: code_verifier})

    # Construct the authorization url
    # Note how we pass in the customer_id as the state param so that we can look up the code_verifier in calllback
    auth_url = (f"{KLAVIYO_AUTHORIZATION_URL}?response_type=code&client_id={client_id}"
                f"&redirect_uri={redirect_uri}&scope={scope}&code_challenge_method=S256"
                f"&code_challenge={code_challenge}&state={customer_id}")

    # Redirect them to Klaviyo so that they can authorize your app
    return redirect(auth_url)


@app.route('/oauth/klaviyo/callback')
def callback():
    # Get the auth code from the query param
    authorization_code = request.args.get('code')

    # Retrieve code_verifier from session or database
    code_verifier = pkce_data_store.get(customer_id)

    # Exchange code for token
    headers = {
        'Authorization': get_basic_authorization_header(),
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    data = {
        'grant_type': 'authorization_code',
        'code': authorization_code,
        'code_verifier': code_verifier,
        'redirect_uri': redirect_uri
    }
    response = requests.post(KLAVIYO_TOKEN_URL, headers=headers, data=data)

    # Store the token info in your datastore
    token_data_store.update({customer_id: response.json()})

    make_api_call_with_refresh()

    return '<pre>' + json.dumps(response.json(), indent=4) + '</pre>'


def refresh_access_token():
    customer_id = '1234'  # Retrieve this as needed
    token_data = token_data_store.get(customer_id)
    refresh_token = token_data.get('refresh_token')

    headers = {
        'Authorization': get_basic_authorization_header(),
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    data = {
        'grant_type': 'refresh_token',
        'refresh_token': refresh_token
    }

    response = requests.post(KLAVIYO_TOKEN_URL, headers=headers, data=data)

    print('<pre>' + json.dumps(response.json(), indent=4) + '</pre>')
    if response.status_code is 200:
        # Update the stored token info
        token_data_store.update({customer_id: response.json()})
    if response.status_code is 400 and response.json().get('error') == 'invalid_grant':
        # This could be due to the customer uninstalling the integration in Klaviyo, token expiration after 90 days
        # of no-use, token revocation by Klaviyo's internal systems for security reasons, or an incorrect token.
        # 1. Disconnect the integration on your end since the customer will need to re-authorize
        # 2. (Optional) Trigger a win back email to the customer
        pass


def make_api_call_with_refresh():
    token_data = token_data_store.get(customer_id)
    access_token = token_data.get('access_token')

    api_url = 'https://a.klaviyo.com/api/lists'
    headers = {
        'Authorization': f'Bearer {access_token}'
    }

    response = requests.get(api_url, headers=headers)

    if response.status_code == 401:
        # Token is expired, refresh it.
        # Note: You should have a retry mechanism here to prevent an infinite loop
        refresh_access_token()
        make_api_call_with_refresh()
    else:
        # Return the API response
        return response.json()


if __name__ == '__main__':
    webbrowser.open('http://localhost:5001/oauth/klaviyo/authorize')
    app.run(port=5001)
