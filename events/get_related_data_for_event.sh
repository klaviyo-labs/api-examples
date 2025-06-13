# this shell script is used to get related profile and metric data for a given event.

# example 1: get related profile data for a specific event. Set EVENT_ID to the event ID from your Klaviyo account.
EVENT_ID='6e3MwdH2fWm'

curl --request GET \
     --url "https://a.klaviyo.com/api/events/$EVENT_ID/profile" \
     --header "Authorization: Klaviyo-API-Key your-private-api-key" \
     --header "accept: application/vnd.api+json" \
     --header "revision: 2025-04-15"

# example 2: get related metric data for a specific event. Set EVENT_ID to the event ID from your Klaviyo account.
curl --request GET \
     --url "https://a.klaviyo.com/api/events/$EVENT_ID/metric" \
     --header "Authorization: Klaviyo-API-Key your-private-api-key" \
     --header "accept: application/vnd.api+json" \
     --header "revision: 2025-04-15"