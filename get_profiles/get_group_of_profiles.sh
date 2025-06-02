curl --request GET \
     --url 'https://a.klaviyo.com/api/profiles?filter=less-or-equal(subscriptions.email.marketing.suppression.timestamp,2024-01-01T00:00:00)' \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15'