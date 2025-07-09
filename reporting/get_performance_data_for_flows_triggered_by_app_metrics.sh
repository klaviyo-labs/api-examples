# this sample shell script gets flow-specific performance data related to an app metrics.
# for more information, see https://developers.klaviyo.com/en/docs/get_performance_data_for_flows_triggered_by_your_app_metrics

# load your private API key from environment variables
# ensure you have set the environment variable "KLAVIYO_API_KEY" with Klaviyo private API key
PRIVATE_API_KEY='your-private-api-key' # replace with your actual Klaviyo private API key

# Get flows triggered by your metric
# To retrieve flow-specific performance data at the account level, we first need to identify which flows 
# are triggered by your app's metrics within the account.

integration_name="your-integration-name"  # replace with your actual integration name

echo "Fetching metrics for integration: ${integration_name}..."

# use the Get Metrics endpoint to fetch app metrics specific to your integration
# note that the query parameters are URL-encoded
filter="equals(integration.name%2C%27${integration_name}%27)"
fields="name%2Cintegration.id%2Cintegration.name"
metrics_response=$(curl -s -X GET "https://a.klaviyo.com/api/metrics/?filter=${filter}&fields%5Bmetric%5D=${fields}" \
  -H "Authorization: Klaviyo-API-Key ${PRIVATE_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "revision: 2024-10-15")

if [ $? -ne 0 ]; then
    echo "Error fetching metrics"
    exit 1
fi

# extract the metric ID for the "Placed Order" metric
placed_order_metric_id=$(echo "$metrics_response" | jq -r '.data[] | select(.attributes.name == "Placed Order") | .id')

if [ -z "$placed_order_metric_id" ] || [ "$placed_order_metric_id" = "null" ]; then
    echo "Error: Placed Order metric not found. Please check your integration name or metrics."
    exit 1
fi

echo "Found Placed Order metric ID: ${placed_order_metric_id}"

# then, use the Get IDs for Flows Triggered by App Metrics endpoint to fetch flows triggered by the "Placed Order" metric
echo "Fetching flows triggered by metric..."
flows_response=$(curl -s -X GET "https://a.klaviyo.com/api/metrics/${placed_order_metric_id}/flow-triggers/" \
  -H "Authorization: Klaviyo-API-Key ${PRIVATE_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "revision: 2024-10-15")

if [ $? -ne 0 ]; then
    echo "Error fetching flows triggered by metric"
    exit 1
fi

# get the first flow ID from the flows triggered by the metric
flow_id=$(echo "$flows_response" | jq -r '.data[0].id')

if [ -z "$flow_id" ] || [ "$flow_id" = "null" ]; then
    echo "Error: No flows found triggered by the metric."
    exit 1
fi

echo "Found flow ID: ${flow_id}"

# Fetch flow-specific performance data
# Now that we have an ID for a flow that has been triggered by a specified app metric, we can fetch the performance data for that flow.
# This example will query clicks, unique clicks, and unique conversions over a custom time frame, and then query clicks, delivery rate, and open rate on a weekly interval over the last 30 days.

# first, use the Query Flow Values endpoint to query clicks, unique clicks, and unique conversions over a custom time frame
conversion_metric_id="your-conversion-metric-id"  # replace with your actual conversion metric ID
timeframe_start="2023-01-01"  # replace with your desired start date
timeframe_end="2023-01-31"  # replace with your desired end date

echo "Requesting flow performance data for custom timeframe..."
# replace statistics with your statistics of interest
curl -X POST "https://a.klaviyo.com/api/flow-values-reports/" \
  -H "Authorization: Klaviyo-API-Key ${PRIVATE_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "revision: 2024-10-15" \
  -d '{
    "data": {
      "type": "flow-values-report",
      "attributes": {
        "timeframe": {
          "start": "'"${timeframe_start}"'",
          "end": "'"${timeframe_end}"'"
        },
        "statistics": ["clicks","clicks_unique","conversion_uniques"], 
        "conversion_metric_id": "'"${conversion_metric_id}"'",
        "filter": "equals(flow_id,'"'${flow_id}'"')"
      }
    }
  }' | jq '.' || echo "Error fetching flow performance data"

echo ""

# next, use the Query Flow Series endpoint to query clicks, delivery rate, and open rate on a weekly interval over the last 30 days for the same flow.
flow_timeframe="last_30_days"  # replace with your desired timeframe
flow_report_interval="weekly"  # replace with your desired interval, e.g., 'daily', 'hourly', 'weekly', 'monthly'

echo "Requesting weekly flow performance data..."
# replace statistics with your statistics of interest
curl -X POST "https://a.klaviyo.com/api/flow-series-reports/" \
  -H "Authorization: Klaviyo-API-Key ${PRIVATE_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "revision: 2024-10-15" \
  -d '{
    "data": {
      "type": "flow-series-report",
      "attributes": {
        "timeframe": {
          "key": "'"${flow_timeframe}"'"
        },
        "interval": "'"${flow_report_interval}"'",
        "statistics": ["clicks","delivery_rate","open_rate"],
        "filter": "equals(flow_id,'"'${flow_id}'"')",
        "conversion_metric_id": "'"${conversion_metric_id}"'"
      }
    }
  }' | jq '.' || echo "Error fetching weekly flow performance data"

echo ""
echo "Flow-specific performance data requests completed."
echo ""