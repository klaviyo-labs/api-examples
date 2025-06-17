# this Python code example gets related profile and metric data for a given event.
import os
from klaviyo_api import KlaviyoAPI

# load your private API key from environment variables. 
# ensure you have set the environment variable "private_api_key" with Klaviyo private API key that has read access to events, profiles, and metrics. 
private_api_key = os.environ.get("private_api_key")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# example 1: get related profile data for a specific event. Replace event_id with the ID of the event you are interested in.
# note that this is the event's Activity ID rather than Unique ID.
event_id = '6e3MwdH2fWm'

raw_profile_data = klaviyo.Events.get_profile_for_event(event_id)
profile_dict = raw_profile_data.to_dict()

# example 2: get related metric data for a specific event. Replace event_id with the ID of the event you are interested in.
event_id = '6e3MwdH2fWm'

raw_metric_data = klaviyo.Events.get_metric_for_event(event_id)
metric_dict = raw_metric_data.to_dict()
