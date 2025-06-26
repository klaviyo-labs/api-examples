# sample cURL request to the Get Profiles endpoint to retrieve the email and country of all profiles in a Klaviyo account. This code is used in the Get profiles out of Klaviyo via API YouTube video: https://www.youtube.com/watch?v=bHXJlV7wP0Q.
curl -g --request GET \
     --url 'https://a.klaviyo.com/api/profiles?fields[profile]=email,location.country' \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15'
