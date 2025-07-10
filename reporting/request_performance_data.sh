# this sample shell script requests 1:1 matches of campaign, flow, form, and segment performance data shown in the Klaviyo app.
# for more information on the API, see https://developers.klaviyo.com/en/reference/reporting_api_overview

# load your private API key from environment variables
# ensure you have set the environment variable "private_api_key" with Klaviyo private API key
PRIVATE_API_KEY="${KLAVIYO_API_KEY}"  # ensure this environment variable is set before running the script and that your private API key has read access to segment, campaigns, flows, and forms.

# set the conversion metric ID. This example uses the same Placed Order metric ID for all examples.
conversion_metric_id="S2r6Jj"  # replace with your actual conversion metric ID

# example 1: get open rate and click rate for campaigns in the last 30 days
campaign_timeframe="last_30_days"  # replace with your desired timeframe

echo "Requesting campaign performance data..."
curl -X POST "https://a.klaviyo.com/api/campaign-values-reports/" \
  -H "Authorization: Klaviyo-API-Key ${PRIVATE_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "revision: 2024-10-15" \
  -d '{
    "data": {
      "type": "campaign-values-report",
      "attributes": {
        "timeframe": {
          "key": "'"${campaign_timeframe}"'"
        },
        "statistics": ["open_rate", "click_rate"],
        "conversion_metric_id": "'"${conversion_metric_id}"'"
      }
    }
  }' | jq '.' || echo "Error fetching campaign performance data"

echo ""

# example 2: get conversion rate for SMS flows in the last 30 days
flow_timeframe="last_30_days"  # replace with your desired timeframe
flow_filter="equals(send_channel,'sms')"  # filter for SMS flows (optional)

echo "Requesting SMS flow performance data..."
curl -X POST "https://a.klaviyo.com/api/flow-values-reports/" \
  -H "Authorization: Klaviyo-API-Key ${PRIVATE_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "revision: 2024-10-15" \
  -d '{
    "data": {
      "type": "flow-values-report",
      "attributes": {
        "timeframe": {
          "key": "'"${flow_timeframe}"'"
        },
        "statistics": ["conversion_rate"],
        "conversion_metric_id": "'"${conversion_metric_id}"'",
        "filter": "'"${flow_filter}"'"
      }
    }
  }' | jq '.' || echo "Error fetching SMS flow performance data"

echo ""

# example 3: get weekly submit rate and number of form submits for all signup forms in the last 30 days
form_timeframe="last_30_days"  # replace with your desired timeframe
form_report_interval="weekly"  # replace with your desired interval, e.g., 'daily', 'hourly', 'weekly', 'monthly'

echo "Requesting form performance data..."
curl -X POST "https://a.klaviyo.com/api/form-series-reports/" \
  -H "Authorization: Klaviyo-API-Key ${PRIVATE_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "revision: 2024-10-15" \
  -d '{
    "data": {
      "type": "form-series-report",
      "attributes": {
        "timeframe": {
          "key": "'"${form_timeframe}"'"
        },
        "interval": "'"${form_report_interval}"'",
        "statistics": ["submit_rate", "submits"]
      }
    }
  }' | jq '.' || echo "Error fetching form performance data"

echo ""

# example 4: get number of members added to and removed from a specific segment every day this month
segment_id="your-segment-id"  # replace with your actual segment ID
segment_timeframe="this_month"  # replace with your desired timeframe
segment_report_interval="daily"  # replace with your desired interval, e.g., 'daily', 'hourly', 'weekly', 'monthly'

echo "Requesting segment performance data..."
curl -X POST "https://a.klaviyo.com/api/segment-series-reports/" \
  -H "Authorization: Klaviyo-API-Key ${PRIVATE_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "revision: 2024-10-15" \
  -d '{
    "data": {
      "type": "segment-series-report",
      "attributes": {
        "timeframe": {
          "key": "'"${segment_timeframe}"'"
        },
        "interval": "'"${segment_report_interval}"'",
        "statistics": ["members_added", "members_removed"],
        "filter": "equals(segment_id,'"'${segment_id}'"')"
      }
    }
  }' | jq '.' || echo "Error fetching segment performance data"

echo ""
echo "All requests completed."