# this sample code creates a Reset Password event that can be used to trigger a Reset Password flow.
# in a flow email triggered by this event, you can access the customer's unique password reset link using {{ event.PasswordResetLink }}

# set PASSWORD_RESET_LINK as the actual password reset link you want to send to the customer.
# set CUSTOMER_EMAIL as the email address of the customer who requested the password reset.
PASSWORD_RESET_LINK='https://www.yourwebsite.com/reset-password?unique_token=12345'
CUSTOMER_EMAIL='customer@email.com'

# replace 'your-private-api-key' with your actual Klaviyo private API key that has write access to events.
curl --request POST \
     --url https://a.klaviyo.com/api/events \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data '
{
    "data": {
        "type": "event",
        "attributes": {
            "properties": {
                "PasswordResetLink": "'$PASSWORD_RESET_LINK'"
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
                        "email": "'$CUSTOMER_EMAIL'"
                    }
                }
            }
        }
    }
}
'