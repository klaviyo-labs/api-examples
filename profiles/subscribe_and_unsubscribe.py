# this sample Python code subscribes and unsubscribes a profile from email and SMS marketing.
# see https://developers.klaviyo.com/en/reference/bulk_subscribe_profiles and https://developers.klaviyo.com/en/reference/bulk_unsubscribe_profiles for more details.

import os
from klaviyo_api import KlaviyoAPI

# Load your private API key from environment variables. Note that this API key needs to have write access to profiles, lists, and subscriptions.
private_api_key = os.environ.get("private_api_key")
klaviyo = KlaviyoAPI(private_api_key)

# Example 1: Subscribe a profile to email and SMS marketing
customer_email = 'CUSTOMER_EMAIL'  # replace with the email address
customer_phone_number = '+15555555555'  # replace with the phone number
list_id = 'YOUR_LIST_ID'  # replace with your list ID

subscribe_profile_request_body = {
    "data": {
        "type": "profile-subscription-bulk-create-job",
        "attributes": {
            "profiles": {
                "data": [
                    {
                        "type": "profile",
                        "attributes": {
                            "subscriptions": {
                                "email": {
                                    "marketing": {
                                        "consent": "SUBSCRIBED"
                                    }
                                },
                                "sms": {
                                    "marketing": {
                                        "consent": "SUBSCRIBED"
                                    },
                                    "transactional": {
                                        "consent": "SUBSCRIBED"
                                    }
                                }
                            },
                            "email": customer_email,
                            "phone_number": customer_phone_number
                        }
                    }
                ]
            },
            "historical_import": False
        },
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

response = klaviyo.Profiles.bulk_subscribe_profiles(subscribe_profile_request_body)

# Example 2: Subscribe one profile to email marketing, and one to SMS marketing and transactional SMS
customer_email_1 = 'CUSTOMER_EMAIL_1'  # replace with first customer's email
customer_email_2 = 'CUSTOMER_EMAIL_2'  # replace with second customer's email
customer_phone_2 = '+15555555556'      # replace with second customer's phone number
list_id_bulk = 'YOUR_LIST_ID'          # replace with your list ID

subscribe_profiles_request_body = {
    "data": {
        "type": "profile-subscription-bulk-create-job",
        "attributes": {
            "profiles": {
                "data": [
                    {
                        "type": "profile",
                        "attributes": {
                            "subscriptions": {
                                "email": {
                                    "marketing": {
                                        "consent": "SUBSCRIBED"
                                    }
                                }
                            },
                            "email": customer_email_1
                        }
                    },
                    {
                        "type": "profile",
                        "attributes": {
                            "subscriptions": {
                                "sms": {
                                    "marketing": {
                                        "consent": "SUBSCRIBED"
                                    },
                                    "transactional": {
                                        "consent": "SUBSCRIBED"
                                    }
                                }
                            },
                            "email": customer_email_2,
                            "phone_number": customer_phone_2
                        }
                    }
                ]
            },
            "historical_import": False
        },
        "relationships": {
            "list": {
                "data": {
                    "type": "list",
                    "id": list_id_bulk
                }
            }
        }
    }
}

response = klaviyo.Profiles.bulk_subscribe_profiles(subscribe_profiles_request_body)

# Example 3: Unsubscribe a profile from email and SMS marketing
customer_email_unsubscribe = 'CUSTOMER_EMAIL'  # replace with the email address
customer_phone_number_unsubscribe = '+15555555555'  # replace with the phone number
list_id_unsubscribe = 'YOUR_LIST_ID'  # replace with your list ID

unsubscribe_profile_request_body = {
    "data": {
        "type": "profile-subscription-bulk-delete-job",
        "attributes": {
            "profiles": {
                "data": [
                    {
                        "type": "profile",
                        "attributes": {
                            "subscriptions": {
                                "email": {
                                    "marketing": {
                                        "consent": "UNSUBSCRIBED"
                                    }
                                },
                                "sms": {
                                    "marketing": {
                                        "consent": "UNSUBSCRIBED"
                                    },
                                    "transactional": {
                                        "consent": "UNSUBSCRIBED"
                                    }
                                }
                            },
                            "email": customer_email_unsubscribe,
                            "phone_number": customer_phone_number_unsubscribe
                        }
                    }
                ]
            },
            "historical_import": False
        },
        "relationships": {
            "list": {
                "data": {
                    "type": "list",
                    "id": list_id_unsubscribe
                }
            }
        }
    }
}

response = klaviyo.Profiles.bulk_unsubscribe_profiles(unsubscribe_profile_request_body)
