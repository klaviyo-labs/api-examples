# this sample Python code suppresses and unsuppresses profiles in Klaviyo.
# for more information, see https://developers.klaviyo.com/en/reference/bulk_suppress_profiles and https://developers.klaviyo.com/en/reference/bulk_unsuppress_profiles.

import os
from klaviyo_api import KlaviyoAPI
from datetime import datetime

# load your private API key from environment variables. 
# ensure you have set the environment variable "private_api_key" with Klaviyo private API key that has write access to profiles and subscriptions.
private_api_key = os.environ.get("private_api_key")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# example 1: suppress a profile.
customer_email = 'customer_email_to_suppress'  # replace with the email of the profile you want to suppress.

suppress_body = {
  "data": {
    "type": "profile-suppression-bulk-create-job",
    "attributes": {
      "profiles": {
        "data": [
          {
            "type": "profile",
            "attributes": {
              "email": customer_email
            }
          }
        ]
      }
    }
  }
}

klaviyo.Profiles.bulk_suppress_profiles(suppress_body)

# example 2: suppress all profiles in a specific list. 
list_id = 'YOUR_LIST_ID'  # replace with the list ID you want to suppress profiles from.

suppress_list_body = {
  "data": {
    "type": "profile-suppression-bulk-create-job",
    "attributes": {},
    "relationships": {
      "list": {
        "data": {
          "type": "list",
          "id": list_id
        }
      }
    }
  }
}

klaviyo.Profiles.bulk_suppress_profiles(suppress_list_body)

# example 3: unsuppress 2 profiles
# note that this will only remove suppressions with reason USER_SUPPRESSED. Unsubscribed profiles and suppressed profiles for other reasons will not be affected.
first_email_to_unsuppress = 'first_customer_email_to_unsuppress'  # replace with the ID of the first profile you want to unsuppress.
second_email_to_unsuppress = 'second_customer_email_to_unsuppress'  # replace with the ID of the second profile you want to unsuppress.

unsuppress_body = {
  "data": {
    "type": "profile-suppression-bulk-delete-job",
    "attributes": {
      "profiles": {
        "data": [
          {
            "type": "profile",
            "attributes": {
              "email": first_email_to_unsuppress
            }
          },
          {
            "type": "profile",
            "attributes": {
              "email": second_email_to_unsuppress
            }
          }
        ]
      }
    }
  }
}

klaviyo.Profiles.bulk_unsuppress_profiles(unsuppress_body)