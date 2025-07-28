# this sample shell script returns the value of important statistics for a given campaign, flow, form, or segment in the past year.
# for more information on the API, see https://developers.klaviyo.com/en/reference/reporting_api_overview

# load your private API key from environment variables
# ensure you have set the environment variable "KLAVIYO_API_KEY" with Klaviyo private API key
PRIVATE_API_KEY="${KLAVIYO_API_KEY}"  # ensure this environment variable is set before running the script and that your private API key has read access to segments, campaigns, flows, and forms.

# set the conversion metric ID. This example uses the same Placed Order metric ID for all examples.
conversion_metric_id="conversion_metric_id"  # replace with your actual conversion metric ID

# example 1: get open rate, click rate, conversion rate, and conversion value for a specific campaign in the last 30 days
campaign_timeframe="last_30_days"  # replace with your desired timeframe
campaign_id="your-campaign-id"  # replace with your actual campaign ID

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
        "statistics": ["open_rate", "click_rate", "conversion_rate", "conversion_value"],
        "conversion_metric_id": "'"${conversion_metric_id}"'",
        "filter": "equals(campaign_id,'"'${campaign_id}'"')"
      }
    }
  }' | jq '.' || echo "Error fetching campaign performance data"

echo ""

# example 2: get open rate, click rate, conversion rate, and conversion value for a specific flows in the last 12 months
flow_timeframe="last_12_months"  # replace with your desired timeframe
flow_id="your-flow-id"  # replace with your actual flow ID

echo "Requesting flow performance data..."
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
        "statistics": ["open_rate", "click_rate", "conversion_rate", "conversion_value"],
        "conversion_metric_id": "'"${conversion_metric_id}"'",
        "filter": "equals(flow_id,'"'${flow_id}'"')"
      }
    }
  }' | jq '.' || echo "Error fetching flow performance data"

echo ""

# example 3: get the number of form views, form submissions, and submit rate for a specific signup form in the last 30 days
form_id="your-form-id"  # replace with your actual form ID
form_timeframe="last_30_days"  # replace with your desired timeframe

echo "Requesting form performance data..."
curl -X POST "https://a.klaviyo.com/api/form-values-reports/" \
  -H "Authorization: Klaviyo-API-Key ${PRIVATE_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "revision: 2024-10-15" \
  -d '{
    "data": {
      "type": "form-values-report",
      "attributes": {
        "timeframe": {
          "key": "'"${form_timeframe}"'"
        },
        "statistics": ["viewed_form", "submits", "submit_rate"],
        "filter": "equals(form_id,'"'${form_id}'"')"
      }
    }
  }' | jq '.' || echo "Error fetching form performance data"

echo ""

# example 4: get number of members added to, removed from, and total members in a specific segment in the last 30 days
segment_id="your-segment-id"  # replace with your actual segment ID
segment_timeframe="last_30_days"  # replace with your desired timeframe

echo "Requesting segment performance data..."
curl -X POST "https://a.klaviyo.com/api/segment-values-reports/" \
  -H "Authorization: Klaviyo-API-Key ${PRIVATE_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "revision: 2024-10-15" \
  -d '{
    "data": {
      "type": "segment-values-report",
      "attributes": {
        "timeframe": {
          "key": "'"${segment_timeframe}"'"
        },
        "statistics": ["members_added", "members_removed", "total_members"],
        "filter": "equals(segment_id,'"'${segment_id}'"')"
      }
    }
  }' | jq '.' || echo "Error fetching segment performance data"

echo ""
echo "All requests completed."
