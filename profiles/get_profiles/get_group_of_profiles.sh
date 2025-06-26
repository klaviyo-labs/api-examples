# sample cURL request to the Get Profiles endpoint to retrieve all profiles in a Klaviyo account that were suppressed after January 1, 2024. This code is used in the Get profiles out of Klaviyo via API YouTube video: https://www.youtube.com/watch?v=bHXJlV7wP0Q.
curl --request GET \
     --url 'https://a.klaviyo.com/api/profiles?filter=less-or-equal(subscriptions.email.marketing.suppression.timestamp,2024-01-01T00:00:00)' \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15'
