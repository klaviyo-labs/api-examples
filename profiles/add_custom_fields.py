# this sample Python code adds custom fields to a profile that can be used for segmentation, flows, and template personalization.
# see https://developers.klaviyo.com/en/reference/update_profile for more details.

import os
from klaviyo_api import KlaviyoAPI
from datetime import datetime

# load your private API key from environment variables. 
# ensure you have set the environment variable "private_api_key" with Klaviyo private API key that has write access to profiles.
private_api_key = os.environ.get("private_api_key")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# example 1: Update a profile with custom fields
profile_id = 'YOUR_PROFILE_ID' # replace with the profile ID you want to update

# define custom fields to add or update
custom_fields = {
  'Favorite Color': 'Blue',
  'Loyalty Member': True,
  'Last Purchase Date': '2023-10-01',
  'Total Spend': 150.75
}

body = {
    "data": {
        "type": 'profile',
        "id": profile_id,
        "attributes": {
            "properties": custom_fields
        }
    }  
}

klaviyo.Profiles.update_profile(profile_id,body)

# example 2: If you don't know the profile ID, first use Get Profiles to find the profile by email, then update it.
# set customer_email to the email address of the profile whose events you are looking for.
customer_email = 'CUSTOMER_EMAIL' # replace with the email address of the profile you want to update

# use the Get Profiles endpoint to retrieve the profile ID using the email address.
profile = klaviyo.Profiles.get_profiles(filter=f"equals(email,'{customer_email}')")
new_profile_id = profile.data[0].id

# use Update Profile to add custom fields to the profile
# note that this uses the same custom fields as above, just with the new_profile_id.
new_profile_body = {
    "data": {
        "type": 'profile',
        "id": new_profile_id,
        "attributes": {
            "properties": custom_fields
        }
    }  
}

klaviyo.Profiles.update_profile(new_profile_id,new_profile_body)