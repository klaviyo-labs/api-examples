# this sample Python code creates a Reset Password event that can be used to trigger a Reset Password flow.
# in a flow email triggered by this event, you can access the customer's unique password reset link using {{ event.PasswordResetLink }}
import os
from klaviyo_api import KlaviyoAPI

klaviyo = KlaviyoAPI(os.environ["private_api_key"])

body = {
    "data": {
        "type": "event",
        "attributes": {
            "properties": {
                "PasswordResetLink": "https://www.yourwebsite.com/reset-password?unique_token=12345"
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
                        "email": "customer@email.com"
                    }
                }
            }
        }
    }
}

klaviyo.Events.create_event(body)