// this sample JavaScript code adds custom fields to a profile that can be used for segmentation, flows, and template personalization.
// see https://developers.klaviyo.com/en/reference/update_profile for more details.

import { ApiKeySession, ProfilesApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have write access to profiles.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

const session = new ApiKeySession(apiKey)
const profilesApi = new ProfilesApi(session)

// example 1: Update a profile with custom fields
const profileId = 'YOUR_PROFILE_ID' // replace with the profile ID you want to update

// define custom fields to add or update
const customFields = {
  'Favorite Color': 'Blue',
  'Loyalty Member': true,
  'Last Purchase Date': '2023-10-01',
  'Total Spend': 150.75
}

const body = {
  data: {
    type: 'profile',
    id: profileId,
    attributes: {
      properties: customFields
    }
  } 
}

profilesApi.updateProfile(profileId, body)

// example 2: If you don't know the profile ID, first use Get Profiles to find the profile by email, then update it.

// set customerEmail to the email address of the profile whose events you are looking for.
const customerEmail =  'CUSTOMER_EMAIL' // replace with the email address of the profile you want to update
const profileFilter = `equals(email,'${customerEmail}')`

// use Get Profiles to retrieve the profile ID based on the email address
const profile = await profilesApi.getProfiles({ filter: profileFilter })
const newProfileId = profile.body.data[0].id

// use Update Profile to add custom fields to the profile
// note that this uses the same custom fields as above, just with the newProfileId.
const newProfileBody = {
  data: {
    type: 'profile',
    id: newProfileId,
    attributes: {
      properties: customFields
    }
  } 
}

profilesApi.updateProfile(newProfileId, newProfileBody)