curl --request POST \
     --url https://a.klaviyo.com/api/campaign-values-reports \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data '
{
    "data": {
        "type": "campaign-values-report",
        "attributes": {
            "statistics": [
                "open_rate",
                "click_rate",
                "conversion_value"
            ],   
            "timeframe": {
                "key": "last_30_days"
            },
            "conversion_metric_id": "PhqdJM",
            "filter": "equals(send_channel,'sms')"
        }
    }
}
'