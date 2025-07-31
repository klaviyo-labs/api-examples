# this sample shell script subscribes a profile to an email list using the Klaviyo API.
# see https://developers.klaviyo.com/en/reference/bulk_subscribe_profiles for more details.

PRIVATE_API_KEY='your-private-api-key' # replace with your actual Klaviyo private API key that has write access to profiles.

curl --request POST \
     --url https://a.klaviyo.com/api/profile-subscription-bulk-create-jobs \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data '
{
    "data": {
        "type": "profile-subscription-bulk-create-job",
        "attributes": {
            "custom_source": "checkout",
            "profiles": {
                "data": [
                    {
                        "type": "profile",
                        "attributes": {
                            "email": "janedoe@klaviyo.com",
                            "subscriptions": {
                                "email": {
                                    "marketing": {
                                    "consent": "SUBSCRIBED"
                                    }
                                }
                            }
                        }
                    }
                ]
            }
        }  ,
        "relationships": {
            "list": {
                "data": {
                    "type": "list",
                    "id": "TpkKTE"
                }
            }
        }  
    }
}
'
