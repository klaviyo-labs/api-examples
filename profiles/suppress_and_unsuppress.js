// this sample JavaScript code suppresses and unsuppresses profiles in Klaviyo.
// for more information, see https://developers.klaviyo.com/en/reference/bulk_suppress_profiles and https://developers.klaviyo.com/en/reference/bulk_unsuppress_profiles.

import { ApiKeySession, ProfilesApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have write access to profiles and subscriptions.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

const session = new ApiKeySession(apiKey)
const profilesApi = new ProfilesApi(session)

// example 1: suppress a profile.
const customerEmail = 'CUSTOMER_EMAIL' // replace with the email of the profile you want to suppress

const suppressProfileRequestBody = {
  data: {
    type: "profile-suppression-bulk-create-job",
    attributes: {
      profiles: {
        data: [
          {
            type: "profile",
            attributes: {
              email: customerEmail
            }
          }
        ]
      }
    }
  }
}

const suppressProfileResponse = await profilesApi.bulkSuppressProfiles(suppressProfileRequestBody)

// example 2: suppress all members of a specific list.
const listId = 'YOUR_LIST_ID' // replace with the list ID you want to suppress all members of

const suppressProfilesRequestBody = {
  data: {
    type: "profile-suppression-bulk-create-job",
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

const suppressProfilesResponse = await profilesApi.bulkSuppressProfiles(suppressProfilesRequestBody)

// example 3: unsuppress 2 profiles.
// note that this will only remove suppressions with reason USER_SUPPRESSED. Unsubscribed profiles and suppressed profiles for other reasons will not be affected.
const firstEmailToUnsuppress = 'first customer email to unsuppress' // replace with the email of the first profile you want to unsuppress
const secondEmailToUnsuppress = 'second customer email to unsuppress' // replace with the email of the second profile you want to unsuppress

const unsuppressProfileRequestBody = {
  data: {
    type: "profile-suppression-bulk-delete-job",
    attributes: {
      profiles: {
        data: [
          {
            type: "profile",
            attributes: {
              email: firstEmailToUnsuppress
            }
          },
          {
            type: "profile",
            attributes: {
              email: secondEmailToUnsuppress
            }
          }
        ]
      }
    }
  }
}

const unsuppressProfileResponse = await profilesApi.bulkUnsuppressProfiles(unsuppressProfileRequestBody)