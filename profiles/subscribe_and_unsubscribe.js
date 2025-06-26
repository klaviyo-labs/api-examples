// this sample JavaScript code subscribes and unsubscribes a profile from email and SMS marketing.
// see https://developers.klaviyo.com/en/reference/bulk_subscribe_profiles and https://developers.klaviyo.com/en/reference/bulk_unsubscribe_profiles for more details.

import { ApiKeySession, ProfilesApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have write access to profiles, lists, and subscriptions.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

const session = new ApiKeySession(apiKey)
const profilesApi = new ProfilesApi(session)

// example 1: subscribe a profile to email and SMS marketing.
const customerEmail =  'CUSTOMER_EMAIL' // replace with the email address of the profile you want to subscribe
const customerPhoneNumber = 'CUSTOMER_PHONE_NUMBER' // replace with the phone number of the
const listId = 'YOUR_LIST_ID' // replace with the list ID you want to subscribe the profile to

const subscribeProfileRequestBody = {
  data: {
    type: "profile-subscription-bulk-create-job",
    attributes: {
      profiles: {
        data: [
          {
            type: "profile",
            attributes: {
              subscriptions: {
                email: {
                  marketing: {
                    consent: "SUBSCRIBED"
                  }
                },
                sms: {
                  marketing: {
                    consent: "SUBSCRIBED"
                  },
                  transactional: {
                    consent: "SUBSCRIBED"
                  }
                }
              },
              email: customerEmail,
              phone_number: customerPhoneNumber
            }
          }
        ]
      },
      historical_import: false
    },
    relationships: {
      list: {
        data: {
          type: "list",
          id: listId
        }
      }
    }
  }
}

profilesApi.bulkSubscribeProfiles(subscribeProfileRequestBody)

// example 2: subscribe one profile to email marketing, and one to SMS marketing and transactional SMS.
const customerEmail1 = 'CUSTOMER_EMAIL_1' // replace with the first customer's email
const customerEmail2 = 'CUSTOMER_EMAIL_2' // replace with the second customer's email
const customerPhone2 = 'CUSTOMER_PHONE_2' // replace with the second customer's phone number
const listIdBulk = 'YOUR_LIST_ID' // replace with the list ID you want to subscribe the profiles to

const subscribeProfilesRequestBody = {
  data: {
    type: "profile-subscription-bulk-create-job",
    attributes: {
      profiles: {
        data: [
          {
            type: "profile",
            attributes: {
              subscriptions: {
                email: {
                  marketing: {
                    consent: "SUBSCRIBED"
                  }
                }
              },
              email: customerEmail1
            }
          },
          {
            type: "profile",
            attributes: {
              subscriptions: {
                sms: {
                  marketing: {
                    consent: "SUBSCRIBED"
                  },
                  transactional: {
                    consent: "SUBSCRIBED"
                  }
                }
              },
              email: customerEmail2,
              phone_number: customerPhone2
            }
          }
        ]
      },
      historical_import: false
    },
    relationships: {
      list: {
        data: {
          type: "list",
          id: listIdBulk
        }
      }
    }
  }
}

profilesApi.bulkSubscribeProfiles(subscribeProfilesRequestBody)

// example 3: unsubscribe a profile from email and SMS marketing.
const customerEmailUnsubscribe =  'CUSTOMER_EMAIL' // replace with the email address of the profile you want to unsubscribe
const customerPhoneNumberUnsubscribe = 'CUSTOMER_PHONE_NUMBER' // replace with the phone number
const listIdUnsubscribe = 'YOUR_LIST_ID' // replace with the list ID you want to unsubscribe the profile from

const unsubscribeProfileRequestBody = {
  data: {
    type: "profile-subscription-bulk-delete-job",
    attributes: {
      profiles: {
        data: [
          {  
          type: "profile",
            attributes: {
              subscriptions: {
                email: {
                  marketing: {
                    consent: "UNSUBSCRIBED"
                  }
                },
                sms: {
                  marketing: {
                    consent: "UNSUBSCRIBED"
                  },
                  transactional: {
                    consent: "UNSUBSCRIBED"
                  }
                }
              },
              email: customerEmailUnsubscribe,
              phone_number: customerPhoneNumberUnsubscribe
            }
          }
        ]
      },
      historical_import: false
    },
    relationships: {
      list: {
        data: {
          type: "list",
          id: listIdUnsubscribe
        }
      }
    }
  }
} 

profilesApi.bulkUnsubscribeProfiles(unsubscribeProfileRequestBody)
