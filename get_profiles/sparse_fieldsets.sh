curl -g --request GET \
     --url 'https://a.klaviyo.com/api/profiles?fields[profile]=email,location.country' \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15'