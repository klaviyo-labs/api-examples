# sample cURL request to the Get Profiles endpoint to retrieve all profiles in a Klaviyo account, including subscription data and predictive analytics. This code is used in the Get profiles out of Klaviyo via API YouTube video: https://www.youtube.com/watch?v=bHXJlV7wP0Q.
curl -g --request GET \
     --url 'https://a.klaviyo.com/api/profiles?additional-fields[profile]=subscriptions,predictive_analytics' \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15'
