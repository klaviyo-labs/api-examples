# this Python code example gets related profile and metric data for a given event.
import os
from klaviyo_api import KlaviyoAPI

# klaviyo = KlaviyoAPI(os.environ["private_api_key"])
klaviyo = KlaviyoAPI('pk_78652a565cd4aa0579afbfdf56eb821dda')

# example 1: get related profile data for a specific event. Replace event_id with the ID of the event you are interested in.
# note that this is the event's Activity ID rather than Unique ID.
event_id = '6e3MwdH2fWm'

raw_profile_data = klaviyo.Events.get_profile_for_event(event_id)
profile_dict = raw_profile_data.to_dict()

# example 2: get related metric data for a specific event. Replace event_id with the ID of the event you are interested in.
event_id = '6e3MwdH2fWm'

raw_metric_data = klaviyo.Events.get_metric_for_event(event_id)
metric_dict = raw_metric_data.to_dict()