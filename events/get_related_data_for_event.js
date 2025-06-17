// this JavaScript code is used to get related profile and metric data for a given event.

import { ApiKeySession, EventsApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have read access to events, profiles, and metrics.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

const session = new ApiKeySession(apiKey)
const eventsApi = new EventsApi(session)

// example 1: get related profile data for a specific event. Replace profileEventId with the ID of the event you are interested in.
// note that this is the event's Activity ID rather than Unique ID.
const profileEventId = '6e3MwdH2fWm'

// get profile data related to the event
const profileData = await eventsApi.getProfileForEvent(`${profileEventId}`)

// example 2: get related metric data for a specific event. Replace metricEventId with the ID of the event you are interested in.
const metricEventId = '6e3MwdH2fWm'

// get metric data related to the event
const metricData = await eventsApi.getMetricForEvent(`${metricEventId}`)