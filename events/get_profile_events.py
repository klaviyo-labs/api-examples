# this sample Python code retrieves all events for a specific profile. you can then use these events to power an activity feed.
import os
from klaviyo_api import KlaviyoAPI
from datetime import datetime

klaviyo = KlaviyoAPI(os.environ["private_api_key"])

# set customer_id to the profile ID of the profile whose events you are looking for.
customer_id = '01G9ATZKKMSZMDB76EN6WVMVGM'

klaviyo.Events.get_events(filter=f"equals(profile_id,'{customer_id}')")

# if you do not know the profile ID, first use Get Profiles to retrieve profile ID, then use it in the Get Events request.
# set customer_email to the email address of the profile whose events you are looking for.
customer_email = 'michaela.klaviyo@gmail.com'

data = klaviyo.Profiles.get_profiles(filter=f"equals(email,'{customer_email}')")
id = data.data[0].id

klaviyo.Events.get_events(filter=f"equals(profile_id,'{id}')")