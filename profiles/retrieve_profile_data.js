// this sample JavaScript code retrieves profiles data, consent status, and predictive analytics.
// for more information, see https://developers.klaviyo.com/en/reference/get_profile and https://developers.klaviyo.com/en/reference/get_profiles

import { ApiKeySession, ProfilesApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have read access to profiles
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

const session = new ApiKeySession(apiKey)
const profilesApi = new ProfilesApi(session)

// example 1: get all profile data for a specific profile.  
const profileId = 'YOUR_PROFILE_ID' // replace with the profile ID you want to retrieve

const profile = await profilesApi.getProfile(profileId)
console.log('Profile Data:', profile)

// example 2: get profile data, including consent status and predictive analytics, for the same profile.
const profileWithConsentAndAnalytics = await profilesApi.getProfile(profileId, { additionalFieldsProfile: ['subscriptions','predictive_analytics'] })
console.log('Profile Data with Consent and Predictive Analytics:', profileWithConsentAndAnalytics)

// example 3: if you don't know the profile ID, first use Get Profiles to find the profile by email. Then,  use Get Profile to retrieve profiles data
// set customerEmail to the email address of the profile whose events you are looking for.
const customerEmail =  'CUSTOMER_EMAIL' // replace with the email address of the profile you want to update
const profileFilter = `equals(email,'${customerEmail}')`

// use Get Profiles to retrieve the profile ID based on the email address
const profileDataFromEmail = await profilesApi.getProfiles({ filter: profileFilter })
const newProfileId = profileDataFromEmail.body.data[0].id

// use Get Profile to retrieve the profile data based on the newProfileId
const profileFromEmail = await profilesApi.getProfile(newProfileId,{ additionalFieldsProfile: ['subscriptions','predictive_analytics'] })
console.log('Profile Data from Email:', profileFromEmail)