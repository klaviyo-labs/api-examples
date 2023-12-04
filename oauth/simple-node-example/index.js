import 'dotenv/config'
import express from 'express';
import axios from 'axios';
import * as crypto from "crypto";
import open from 'open';

const app = express();
const port = 5001;

const KLAVIYO_AUTHORIZATION_URL = "https://www.klaviyo.com/oauth/authorize"
const KLAVIYO_TOKEN_URL = "https://a.klaviyo.com/oauth/token"

// Customer and token data store
const customerId = '1234';
const pkceDataStore = {};
const tokenDataStore = {};

const clientId = process.env.CLIENT_ID;
const clientSecret = process.env.CLIENT_SECRET;
const redirectUri = 'http://localhost:5001/oauth/klaviyo/callback';
const scope = 'list:read list:write campaigns:write metrics:read';

function generateCodes() {
      const base64URLEncode = (str) => {
          return str.toString('base64')
              .replace(/\+/g, '-')
              .replace(/\//g, '_')
              .replace(/=/g, '');
      }
      const verifier = base64URLEncode(crypto.randomBytes(32));

      const sha256 = (buffer) => {
          return crypto.createHash('sha256').update(buffer).digest();
      }
      const challenge = base64URLEncode(sha256(verifier));

      return {
          codeVerifier: verifier,
          codeChallenge: challenge
      }
}

function getBasicAuthorizationHeader() {
  return 'Basic ' + Buffer.from(`${clientId}:${clientSecret}`).toString('base64');
}

app.get('/oauth/klaviyo/authorize', (req, res) => {
  const { codeVerifier, codeChallenge} = generateCodes();

  pkceDataStore[customerId] = codeVerifier;

  const authUrl = `${KLAVIYO_AUTHORIZATION_URL}?response_type=code&client_id=${clientId}` +
    `&redirect_uri=${redirectUri}&scope=${scope}&code_challenge_method=S256` +
    `&code_challenge=${codeChallenge}&state=${customerId}`;

  res.redirect(authUrl);
});

app.get('/oauth/klaviyo/callback', async (req, res) => {
  const authorizationCode = req.query.code;
  const codeVerifier = pkceDataStore[customerId];

  try {
    const params = new URLSearchParams();
    params.append('grant_type', 'authorization_code');
    params.append('code', authorizationCode);
    params.append('code_verifier', codeVerifier);
    params.append('redirect_uri', redirectUri);
    const response = await axios.post(KLAVIYO_TOKEN_URL, params, {
      headers: { 'Authorization': getBasicAuthorizationHeader() }
    });

    tokenDataStore[customerId] = response.data;
    await makeApiCallWithRefresh();

    res.send(`<pre>${JSON.stringify(response.data, null, 4)}</pre>`);
  } catch (error) {
    console.error(error);
    res.send('Error exchanging code for token.');
  }
});

async function refreshAccessToken() {
  const tokenData = tokenDataStore[customerId];
  const refreshToken = tokenData.refresh_token;

  try {
    const params = new URLSearchParams();
    params.append('grant_type', 'refresh_token');
    params.append('refresh_token', refreshToken);
    const response = await axios.post(KLAVIYO_TOKEN_URL, params, {
      headers: { 'Authorization': getBasicAuthorizationHeader() }
    });

    console.log(`<pre>${JSON.stringify(response.data, null, 4)}</pre>`);
    if (response.status === 200) {
      tokenDataStore[customerId] = response.data;
    }
    if (response.status === 400 && response.data.error === 'invalid_grant') {
      /**
       * This could be due to the customer uninstalling the integration in Klaviyo, token expiration after 90 days
       * of no-use, token revocation by Klaviyo's internal systems for security reasons, or an incorrect token.
       * 1. Disconnect the integration on your end since the customer will need to re-authorize
       * 2. (Optional) Trigger a win back email to the customer
       */
    }
  } catch (error) {
    console.error('Error refreshing access token.');
  }
}

async function makeApiCallWithRefresh() {
  const tokenData = tokenDataStore[customerId];
  const accessToken = tokenData.access_token;

  try {
    const response = await axios.get(`${KLAVIYO_API_URL}/api/lists`, {
      headers: { 'Authorization': `Bearer ${accessToken}` }
    });

    return response.data;
  } catch (error) {
    if (error.response && error.response.status === 401) { 
      // Token is expired, refresh it.
      // Note: You should have a retry mechanism here to prevent an infinite loop
    
      await refreshAccessToken();
      return makeApiCallWithRefresh();
    } else {
      console.error('Error making API call.');
    }
  }
}

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
  open(`http://localhost:${port}/oauth/klaviyo/authorize`);
});
