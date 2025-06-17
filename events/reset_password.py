# this sample Python code creates a Reset Password event that can be used to trigger a Reset Password flow.
# in a flow email triggered by this event, you can access the customer's unique password reset link using {{ event.PasswordResetLink }}
import os
from klaviyo_api import KlaviyoAPI

# load your private API key from environment variables. 
# ensure you have set the environment variable "private_api_key" with Klaviyo private API key that has write access to events. 
private_api_key = os.environ.get("private_api_key")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# replace the password reset link and customer email with your values.
password_reset_link = "https://www.yourwebsite.com/reset-password?unique_token=12345"
customer_email = "customer@email.com"

# create the Reset Password event.
body = {
    "data": {
        "type": "event",
        "attributes": {
            "properties": {
                "PasswordResetLink": password_reset_link
            },
            "metric": {
                "data": {
                    "type": "metric",
                    "attributes": {
                        "name": "Reset Password"
                    }
                }
            },
            "profile": {
                "data": {
                    "type": "profile",
                    "attributes": {
                        "email": customer_email
                    }
                }
            }
        }
    }
}

klaviyo.Events.create_event(body)