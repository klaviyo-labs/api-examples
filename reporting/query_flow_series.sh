# sample cURL request to the Query Flow Series endpoint. This code is used in the Analyze marketing performance with reporting APIs YouTube video: https://www.youtube.com/watch?v=tM0wmuNnukU
curl --request POST \
     --url https://a.klaviyo.com/api/flow-series-reports \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data '
    {
        "data": {
            "type": "flow-series-report",
            "attributes": {
                "statistics": [
                    "open_rate",
                    "click_rate",
                    "conversion_value"
                ],
                "timeframe": {
                    "key": "this_year"
                },
                "interval": "monthly",
                "conversion_metric_id": "PhqdJM",
                "filter": "equals(flow_id,'WmgthX')"
            }
        }
    }
    '
