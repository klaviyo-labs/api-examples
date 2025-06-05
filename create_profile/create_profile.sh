curl --request POST \
     --url https://a.klaviyo.com/api/profile-import \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data '
    {
        "data": {
            "type": "profile",
            "attributes": {
                "email": "michaela@gmail.com",
                "first_name": "Michaela",
                "location": {
                    "city": "Boston"
                },
                "properties": {
                    "Favorite coffee flavor": "vanilla"
                }
            }
        }
    }
    '