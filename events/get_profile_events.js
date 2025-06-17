// this sample JavaScript code retrieves all events for a specific profile. you can then use these events to power an activity feed.

import { ApiKeySession, EventsApi, ProfilesApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have read access to events and profiles.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

const session = new ApiKeySession(apiKey)
const eventsApi = new EventsApi(session)

// set customerId to the ID of the profile you want to retrieve events for
const customerId = '01G9ATZKKMSZMDB76EN6WVMVGM'

const filter = `equals(profile_id,'${customerId}')`
const profileEvents = await eventsApi.getEvents({ filter })
console.log('Profile Events:', profileEvents)

// if you do not know the customer's profile ID, first use Get Profiles to retrieve profile ID, then use it in the Get Events request.

// instantiate profilesAPI
const profilesApi = new ProfilesApi(session)

// set customerEmail to the email address of the profile whose events you are looking for.
const customerEmail = 'michaela.klaviyo@gmail.com'
const profileFilter = `equals(email,'${customerEmail}')`

// use Get Profiles to retrieve the profile ID based on the email address
const profile = await profilesApi.getProfiles({ filter: profileFilter })
const profileId = profile.body.data[0].id

// use Get Events to retrieve all events for the profile ID
const eventsFilter = `equals(profile_id,'${profileId}')`
const profileEventsByEmail = await eventsApi.getEvents({ filter: eventsFilter })
console.log('Profile Events by Email:', profileEventsByEmail)