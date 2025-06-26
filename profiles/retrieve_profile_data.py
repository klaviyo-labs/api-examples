# this sample Python code retrieves profiles data, consent status, and predictive analytics.
# for more information, see https://developers.klaviyo.com/en/reference/get_profile and https://developers.klaviyo.com/en/reference/get_profiles

import os
from klaviyo_api import KlaviyoAPI
from datetime import datetime

# load your private API key from environment variables. 
# ensure you have set the environment variable "private_api_key" with Klaviyo private API key that has read access to profiles.
private_api_key = os.environ.get("private_api_key")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# example 1: get all profile data for a specific profile.  
profile_id = 'YOUR_PROFILE_ID' # replace with the profile ID you want to retrieve
profile = klaviyo.Profiles.get_profile(profile_id)

print(f"Profile Data: {profile}")

# example 2: get profile data, including consent status and predictive analytics, for the same profile.
profile_with_consent_and_analytics = klaviyo.Profiles.get_profile(profile_id,additional_fields_profile=["subscriptions","predictive_analytics"])

print(f"Profile Data including consent and predictive analytics: {profile_with_consent_and_analytics}")

# example 3: if you don't know the profile ID, first use Get Profiles to find the profile by email. Then,  use Get Profile to retrieve profiles data
# set customer_email to the email address of the profile whose events you are looking for.
customer_email = 'CUSTOMER_EMAIL' # replace with the email address of the profile you want to update

# use the Get Profiles endpoint to retrieve the profile ID using the email address.
profile_data_from_email = klaviyo.Profiles.get_profiles(filter=f"equals(email,'{customer_email}')")
new_profile_id = profile_data_from_email.data[0].id

# use Get Profile to retrieve profiles data, including consent status and predictive analytics, for the same profile.
profile_from_email = klaviyo.Profiles.get_profile(new_profile_id,additional_fields_profile=["subscriptions","predictive_analytics"])
print(f"Profile Data from email: {profile_from_email}")