# sample cURL request to the Create or Update Profile endpoint to create a new profile. This code is used in the Create and update a Klaviyo profile via API YouTube video: https://www.youtube.com/watch?v=Lir9g0pQfCM.
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
