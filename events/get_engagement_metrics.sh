# this sample shell script retrieves email engagement metrics that can be used in data analysis.
# the first example gets all Opened Email events.
# the second example gets all Clicked Email events for a specific timeframe.

# example 1: get all Opened Email events. To use this request, set OPENED_EMAIL_METRIC_ID to be the Opened Email metric ID from your Klaviyo account.
# note that the filter is URL encoded. 
OPENED_EMAIL_METRIC_ID='Xj5uUn'
curl --request GET \
     --url 'https://a.klaviyo.com/api/events?filter=equals%28metric_id%2C%27'$OPENED_EMAIL_METRIC_ID'%27%29' \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15'

# example 2: get all Clicked Email events from November 2024. Set CLICKED_EMAIL_METRIC_ID to the Clicked Email metric ID from your Klaviyo account. Set START_DATE and END_DATE as your dates of interest.
# note that the filter is URL encoded. 
CLICKED_EMAIL_METRIC_ID='UmeLw3'
START_DATE="2024-11-01T00:00:00"
END_DATE="2024-12-01T00:00:00"
curl --request GET \
     --url 'https://a.klaviyo.com/api/events?filter=and%28equals%28metric_id%2C%27'$CLICKED_EMAIL_METRIC_ID'%27%29%2Cgreater-or-equal%28datetime%2C'$START_DATE'%29%2Cless-than%28datetime%2C'$END_DATE'%29%29' \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15'