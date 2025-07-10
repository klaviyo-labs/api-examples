# this sample Python code returns the value of important statistics for a given campaign, flow, form, or segment in the past year.
# for more information on the API, see https://developers.klaviyo.com/en/reference/reporting_api_overview

import os
from klaviyo_api import KlaviyoAPI
from datetime import datetime

# load your private API key from environment variables. 
# ensure you have set the environment variable "KLAVIYO_API_KEY" with Klaviyo private API key that has read access to segments, campaigns, flows, and forms.
private_api_key = os.environ.get("KLAVIYO_API_KEY")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# set the conversion metric ID. This example uses the same Placed Order metric ID for all examples. 
conversion_metric_id = 'conversion_metric_id'  # replace with your actual conversion metric ID

# example 1: get open rate, click rate, conversion rate, and conversion value for a specific campaign in the last 30 days
campaign_timeframe = 'last_30_days'  # replace with your desired timeframe
campaign_performance_statistics = ['open_rate', 'click_rate', 'conversion_rate', 'conversion_value']  # replace with your desired statistics
campaign_id = 'your-campaign-id'  # replace with your actual campaign ID

# set up the body of the Query Campaign Values request
campaign_performance_body = {
    'data': {
        'type': "campaign-values-report",
        'attributes': {
            'timeframe': {
                'key': campaign_timeframe,
            },
            'statistics': campaign_performance_statistics,
            'conversion_metric_id': conversion_metric_id,
            'filter': f"equals(campaign_id,'{campaign_id}')"
        }
    }
}

# request campaign performance data
try:
    response = klaviyo.Reporting.query_campaign_values(campaign_performance_body)
    print('Campaign Performance:', response.data)
except Exception as error:
    print('Error fetching campaign performance:', error)

# example 2: get open rate, click rate, conversion rate, and conversion value for a specific flows in the last 12 months
flow_timeframe = 'last_12_months'  # replace with your desired timeframe
flow_performance_statistics = ['open_rate', 'click_rate', 'conversion_rate', 'conversion_value']  # replace with your desired statistics
flow_id = 'your-flow-id'  # replace with your actual flow ID

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

# example 3: get the number of form views, form submissions, and submit rate for a specific signup form in the last 30 days
form_id = 'your-form-id'  # replace with your actual form ID
form_timeframe = 'last_30_days'  # replace with your desired timeframe
form_performance_statistics = ['viewed_form', 'submits', 'submit_rate']  # replace with your desired statistics

# set up the body of the Query Form Values request
form_performance_body = {
    'data': {
        'type': "form-values-report",
        'attributes': {
            'timeframe': {
                'key': form_timeframe,
            },
            'statistics': form_performance_statistics,
            'filter': f"equals(form_id,'{form_id}')"
        }
    }
}

# request form performance data
try:
    response = klaviyo.Reporting.query_form_values(form_performance_body)
    print('Form Performance:', response.data)
except Exception as error:
    print('Error fetching form performance:', error)

# example 4: get number of members added to, removed from, and total members in a specific segment in the last 30 days
segment_id = 'your-segment-id'  # replace with your actual segment ID 
segment_timeframe = 'last_30_days'  # replace with your desired timeframe
segment_performance_statistics = ['members_added', 'members_removed', 'total_members']  # replace with your desired statistics

# set up the body of the Query Segment Values request
segment_performance_body = {
    'data': {
        'type': "segment-values-report",
        'attributes': {
            'timeframe': {
                'key': segment_timeframe,
            },
            'statistics': segment_performance_statistics,
            'filter': f"equals(segment_id,'{segment_id}')"
        }
    }
}

# request segment performance data
try:
    response = klaviyo.Reporting.query_segment_values(segment_performance_body)
    print('Segment Performance:', response.data)
except Exception as error:
    print('Error fetching segment performance:', error)