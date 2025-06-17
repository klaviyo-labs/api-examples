// this sample JavaScript code retrieves email engagement metrics that can be used in data analysis.
// the first example gets all Opened Email events.
// the second example gets all Clicked Email events for a specific timeframe.

import { ApiKeySession, EventsApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have read access to events.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

const session = new ApiKeySession(apiKey)
const eventsApi = new EventsApi(session)

// example 1: Get all Opened Email events
const openedEmailMetricId = 'Xj5uUn'

const openedEmailFilter = `equals(metric_id,'${openedEmailMetricId}')`
const openedEmailEvents = await eventsApi.getEvents({openedEmailFilter})
console.log('Opened Email Events:', openedEmailEvents)

// example 2: Get all Clicked Email events for a specific timeframe
const clickedEmailMetricId = 'UmeLw3'
const startDate = '2023-01-01T00:00:00Z'
const endDate = '2023-01-31T23:59:59Z'
const clickedEmailFilter = `and(equals(metric_id,'${clickedEmailMetricId}'),greater-or-equal(datetime,${startDate}),less-than(datetime,${endDate}))`

const clickedEmailEvents = await eventsApi.getEvents({filter: clickedEmailFilter})
console.log('Clicked Email Events:', clickedEmailEvents)