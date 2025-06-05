# sample cURL request to the Get Profiles endpoint to retrieve a specific profile from a Klaviyo account. This code is used in the Get profiles out of Klaviyo via API YouTube video: https://www.youtube.com/watch?v=bHXJlV7wP0Q.
curl --request GET \
     --url 'https://a.klaviyo.com/api/profiles?filter=equals("email","michaela.klaviyo@gmail.com")' \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15'
