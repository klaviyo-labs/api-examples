# this sample shell script subscribes and unsubscribes a profile from email and SMS marketing.
# see https://developers.klaviyo.com/en/reference/bulk_subscribe_profiles and https://developers.klaviyo.com/en/reference/bulk_unsubscribe_profiles for more details.


PRIVATE_API_KEY='your-private-api-key' # replace with your actual Klaviyo private API key that has write access to profiles, lists, and subscriptions.

# example 1: subscribe a profile to email and SMS marketing.
CUSTOMER_EMAIL='CUSTOMER_EMAIL' # replace with the email address of the profile you want to subscribe
CUSTOMER_PHONE='+15555555555' # replace with the phone number of the profile you want to subscribe, in E.164 format
LIST_ID='LIST_ID' # replace with the list ID you want to subscribe the profile to

curl --request POST \
     --url https://a.klaviyo.com/api/profile-subscription-bulk-create-jobs \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data '
{
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
                                   "email": "'$CUSTOMER_EMAIL'",
                                   "phone_number": "'$CUSTOMER_PHONE'"
                              }
                         }
                    ]
               },
               "historical_import": false
          },
          "relationships": {
               "list": {
                    "data": {
                         "type": "list",
                         "id": "'$LIST_ID'"
                    }
               }
          }
     }
}
'

# example 2: subscribe one profile to email marketing, and one to SMS marketing and transactional SMS.
CUSTOMER_EMAIL_1='CUSTOMER_EMAIL_1' # replace with the email address of the profile you want to subscribe to email marketing
CUSTOMER_EMAIL_2='CUSTOMER_EMAIL_2' # replace with the email address of the profile you want to subscribe to SMS marketing
CUSTOMER_PHONE_2='+15555555556' # replace with the phone number of the profile you want to subscribe to SMS marketing, in E.164 format
LIST_ID='LIST_ID' # replace with the list ID you want to subscribe the profiles to

curl --request POST \
     --url https://a.klaviyo.com/api/profile-subscription-bulk-create-jobs \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data '
{
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
                                   "email": "'$CUSTOMER_EMAIL_1'"
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
                                   "email": "'$CUSTOMER_EMAIL_2'",
                                   "phone_number": "'$CUSTOMER_PHONE_2'"
                              }
                         }
                    ]
               },
               "historical_import": false
          },
          "relationships": {
               "list": {
                    "data": {
                         "type": "list",
                         "id": "'$LIST_ID'"
                    }
               }
          }
     }
}
'

# example 3: unsubscribe a profile from email, SMS marketing, and transactional SMS.
CUSTOMER_EMAIL_UNSUBSCRIBE='CUSTOMER_EMAIL' # replace with the email address of the profile you want to unsubscribe
CUSTOMER_PHONE_UNSUBSCRIBE='+15555555555' # replace with the phone number of the profile you want to unsubscribe, in E.164 format
LIST_ID_UNSUBSCRIBE='LIST_ID' # replace with the list ID you want to unsubscribe the profile from


curl --request POST \
     --url https://a.klaviyo.com/api/profile-subscription-bulk-delete-jobs \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data '
{
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
                                   "email": "'$CUSTOMER_EMAIL_UNSUBSCRIBE'",
                                   "phone_number": "'$CUSTOMER_PHONE_UNSUBSCRIBE'"
                              }
                         }
                    ]
               }
          },
          "relationships": {
               "list": {
                    "data": {
                         "type": "list",
                         "id": "'$LIST_ID_UNSUBSCRIBE'"
                    }
               }
          }
     }
}
'
