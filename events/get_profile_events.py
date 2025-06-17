# this sample Python code retrieves all events for a specific profile. you can then use these events to power an activity feed.
import os
from klaviyo_api import KlaviyoAPI
from datetime import datetime

# load your private API key from environment variables. 
# ensure you have set the environment variable "private_api_key" with Klaviyo private API key that has read access to events and profiles. 
private_api_key = os.environ.get("private_api_key")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# set customer_id to the profile ID of the profile whose events you are looking for.
customer_id = '01G9ATZKKMSZMDB76EN6WVMVGM'

klaviyo.Events.get_events(filter=f"equals(profile_id,'{customer_id}')")

# if you do not know the profile ID, first use Get Profiles to retrieve profile ID, then use it in the Get Events request.
# set customer_email to the email address of the profile whose events you are looking for.
customer_email = 'michaela.klaviyo@gmail.com'

# use the Get Profiles endpoint to retrieve the profile ID using the email address.
profile = klaviyo.Profiles.get_profiles(filter=f"equals(email,'{customer_email}')")
profile_id = profile.data[0].id

klaviyo.Events.get_events(filter=f"equals(profile_id,'{profile_id}')")
