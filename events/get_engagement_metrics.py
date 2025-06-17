# this sample Python code retrieves email engagement metrics that can be used in data analysis.
# the first example gets all Opened Email events.
# the second example gets all Clicked Email events for a specific timeframe.
import os
from klaviyo_api import KlaviyoAPI
from datetime import datetime

# load your private API key from environment variables. 
# ensure you have set the environment variable "private_api_key" with Klaviyo private API key that has read access to events. 
private_api_key = os.environ.get("private_api_key")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# example 1: get all Opened Email events. Replace opened_email_metric_id with the Opened Email metric ID from your account.
opened_email_metric_id = 'Xj5uUn'

klaviyo.Events.get_events(filter=f"equals(metric_id,'{opened_email_metric_id}')")

# example 2: get all Clicked Email events from November 2024. Replace clicked_email_metric_id with the Clicked Email metric ID from your Klaviyo account. Replace the numbers in start_date and end_date with your dates of interest.
clicked_email_metric_id = 'UmeLw3'
start_date = datetime(2024,11,1,0,0,0)
end_date = datetime(2024,12,1,0,0,0)
start_date_str = start_date.strftime('%Y-%m-%dT%H:%M:%S')
end_date_str = end_date.strftime('%Y-%m-%dT%H:%M:%S')

klaviyo.Events.get_events(filter=f"and(equals(metric_id,'{clicked_email_metric_id}'),greater-or-equal(datetime,{start_date_str}),less-than(datetime,{end_date_str}))")