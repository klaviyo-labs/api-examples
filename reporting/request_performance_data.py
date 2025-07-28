# this sample Python code requests 1:1 matches of campaign, flow, form, and segment performance data shown in the Klaviyo app.
# for more information on the API, see https://developers.klaviyo.com/en/reference/reporting_api_overview

import os
from klaviyo_api import KlaviyoAPI
from datetime import datetime

# load your private API key from environment variables. 
# ensure you have set the environment variable "KLAVIYO_API_KEY" with Klaviyo private API key that has read access to segment, campaigns, flows, and forms.
private_api_key = os.environ.get("KLAVIYO_API_KEY")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# set the conversion metric ID. This example uses the same Placed Order metric ID for all examples. 
conversion_metric_id = 'conversion-metric-id'  # replace with your actual conversion metric ID

# example 1: get open rate and click rate for campaigns in the last 30 days
campaign_timeframe = 'last_30_days'  # replace with your desired timeframe
campaign_performance_statistics = ['open_rate', 'click_rate']  # replace with your desired statistics

# set up the body of the Query Campaign Values request
campaign_performance_body = {
    'data': {
        'type': "campaign-values-report",
        'attributes': {
            'timeframe': {
                'key': campaign_timeframe,
            },
            'statistics': campaign_performance_statistics,
            'conversion_metric_id': conversion_metric_id
        }
    }
}

# request campaign performance data
try:
    response = klaviyo.Reporting.query_campaign_values(campaign_performance_body)
    print('Campaign Performance:', response.data)
except Exception as error:
    print('Error fetching campaign performance:', error)

# example 2: get conversion rate for SMS flows in the last 30 days
flow_timeframe = 'last_30_days'  # replace with your desired timeframe
flow_performance_statistics = ['conversion_rate']  # replace with your desired statistics
flow_filter = "equals(send_channel,'sms')"  # filter for SMS flows (optional)

# set up the body of the Query Flow Values request
flow_performance_body = {
    'data': {
        'type': "flow-values-report",
        'attributes': {
            'timeframe': {
                'key': flow_timeframe,
            },
            'statistics': flow_performance_statistics,
            'conversion_metric_id': conversion_metric_id,
            'filter': flow_filter
        }
    }
}

# request flow performance data
try:
    response = klaviyo.Reporting.query_flow_values(flow_performance_body)
    print('SMS flow Performance:', response.data)
except Exception as error:
    print('Error fetching SMS flow performance:', error)

# example 3: get weekly submit rate and number of form submits for all signup forms in the last 30 days
form_timeframe = 'last_30_days'  # replace with your desired timeframe
form_performance_statistics = ['submit_rate', 'submits']  # replace with your desired statistics
form_report_interval = 'weekly'  # replace with your desired interval, e.g., 'daily', 'hourly', 'weekly', 'monthly'

# set up the body of the Query Form Series request
form_performance_body = {
    'data': {
        'type': "form-series-report",
        'attributes': {
            'timeframe': {
                'key': form_timeframe,
            },
            'interval': form_report_interval,
            'statistics': form_performance_statistics
        }
    }
}

# request form performance data
try:
    response = klaviyo.Reporting.query_form_series(form_performance_body)
    print('Form Performance:', response.data)
except Exception as error:
    print('Error fetching form performance:', error)

# example 4: get number of members added to and removed from a specific segment every day this month
segment_id = 'your-segment-id'  # replace with your actual segment ID
segment_timeframe = 'this_month'  # replace with your desired timeframe
segment_performance_statistics = ['members_added', 'members_removed']  # replace with your desired statistics
segment_report_interval = 'daily'  # replace with your desired interval, e.g., 'daily', 'hourly', 'weekly', 'monthly'

# set up the body of the Query Segment Series request
segment_performance_body = {
    'data': {
        'type': "segment-series-report",
        'attributes': {
            'timeframe': {
                'key': segment_timeframe,
            },
            'interval': segment_report_interval,
            'statistics': segment_performance_statistics,
            'filter': f"equals(segment_id,'{segment_id}')"
        }
    }
}

# request segment performance data
try:
    response = klaviyo.Reporting.query_segment_series(segment_performance_body)
    print('Segment Performance:', response.data)
except Exception as error:
    print('Error fetching segment performance:', error)
