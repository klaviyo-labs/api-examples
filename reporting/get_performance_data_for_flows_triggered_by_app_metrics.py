# this sample Python code gets flow-specific performance data related to an app metrics.
# for more information, see https://developers.klaviyo.com/en/docs/get_performance_data_for_flows_triggered_by_your_app_metrics

import os
from klaviyo_api import KlaviyoAPI
from datetime import datetime

# load your private API key from environment variables. 
# ensure you have set the environment variable "KLAVIYO_API_KEY" with a Klaviyo private API key that has read access to metrics and flows.
private_api_key = os.environ.get("KLAVIYO_API_KEY")
if not private_api_key:
    raise ValueError("Please set the KLAVIYO_API_KEY environment variable.")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# Get flows triggered by your metric
# To retrieve flow-specific performance data at the account level, we first need to identify which flows 
# are triggered by your app's metrics within the account.

integration_name = 'your-integration-name'  # replace with your actual integration name

# use the Get Metrics endpoint to fetch app metrics specific to your integration
try:
    metrics_list = klaviyo.Metrics.get_metrics(
        filter=f"equals(integration.name,'{integration_name}')",
        fields_metric=['name', 'integration.id', 'integration.name']
    )
    
    # of the returned metrics, copy the metric ID(s) that you would like to use to fetch related flows.
    # in this example, we will filter the response to use the metric ID for the "Placed Order" metric.
    placed_order_metric = None
    
    # Safely access the data
    metrics_data = metrics_list.get('data', [])
    if not metrics_data:
        raise ValueError('No metrics data found in response')
    
    for metric in metrics_data:
        if metric['attributes']['name'] == 'Placed Order':
            placed_order_metric = metric
            break
    
    if not placed_order_metric:
        raise ValueError('Placed Order metric not found. Please check your integration name or metrics.')
    
    placed_order_metric_id = placed_order_metric['id']
    
    # then, use the Get IDs for Flows Triggered by App Metrics endpoint to fetch flows triggered by the "Placed Order" metric
    flows_triggered_by_metric = klaviyo.Metrics.get_flows_triggered_by_metric(id=placed_order_metric_id)
    flow_data = flows_triggered_by_metric.data

    if not flow_data:
        raise ValueError('No flows found triggered by this metric')

    # in this example, we will use the first flow returned in the response.
    flow_id = flow_data[0].id

    print(f"Using flow ID: {flow_id}")
    
    # define the timeframe and statistics for the flow performance data
    timeframe_start = '2025-01-01T00:00:00Z'  # replace with your desired start date in ISO 8601 format
    timeframe_end = '2025-02-01T00:00:00Z'  # replace with your desired end date in ISO 8601 format
    flow_performance_statistics = ['clicks', 'clicks_unique', 'conversion_uniques']  # replace with your desired statistics
    conversion_metric_id = 'conversion_metric_id'  # replace with your actual conversion metric ID

    # set up the body of the Query Flow Values request
    flow_performance_body = {
        'data': {
            'type': "flow-values-report",
            'attributes': {
                'timeframe': {
                    'start': timeframe_start,
                    'end': timeframe_end
                },
                'statistics': flow_performance_statistics,
                'conversion_metric_id': conversion_metric_id,
                'filter': f"equals(flow_id,'{flow_id}')"
            }
        }
    }
    
    # request flow performance data
    try:
        response = klaviyo.Reporting.query_flow_values(flow_performance_body)
        print('Flow Performance:', response.data)
    except Exception as error:
        print('Error fetching flow performance:', error)
    
    # next, use the Query Flow Series endpoint to query clicks, delivery rate, and open rate on a weekly interval over the last 30 days for the same flow.
    flow_timeframe = 'last_30_days'  # replace with your desired timeframe
    weekly_flow_performance_statistics = ['clicks', 'delivery_rate', 'open_rate']  # replace with your desired statistics
    flow_report_interval = 'weekly'  # replace with your desired interval, e.g., 'daily', 'hourly', 'weekly', 'monthly'
    
    # set up the body of the Query Flow Series request
    weekly_flow_performance_body = {
        'data': {
            'type': "flow-series-report",
            'attributes': {
                'timeframe': {
                    'key': flow_timeframe,
                },
                'interval': flow_report_interval,
                'statistics': weekly_flow_performance_statistics,
                'filter': f"equals(flow_id,'{flow_id}')",
                'conversion_metric_id': conversion_metric_id
            }
        }
    }
    
    # request flow performance data
    try:
        response = klaviyo.Reporting.query_flow_series(weekly_flow_performance_body)
        print('Weekly Flow Performance:', response.data)
    except Exception as error:
        print('Error fetching weekly flow performance:', error)

except Exception as error:
    print('Error fetching metrics or flows:', error)
