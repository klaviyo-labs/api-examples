curl -g --request GET \
     --url 'https://a.klaviyo.com/api/profiles?additional-fields[profile]=subscriptions,predictive_analytics' \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15'