// this sample JavaScript code creates a Reset Password event that can be used to trigger a Reset Password flow.
// in a flow email triggered by this event, you can access the customer's unique password reset link using {{ event.PasswordResetLink }}

import { ApiKeySession, EventsApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have write access to events.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

// instantiate the API session and events API
const session = new ApiKeySession(apiKey)
const eventsApi = new EventsApi(session)

const passwordResetLink = 'https://www.yourwebsite.com/reset-password?unique_token=12345'
const customerEmail = 'customer@email.com'

// set up event data details
const body = {
  data: {
    type: "event",
    attributes: {
      properties: {
        PasswordResetLink: passwordResetLink
      },
      metric: {
        data: {
          type: "metric",
          attributes: {
            name: "Reset Password"
          }
        }
      },
      profile: {
        data: {
          type: "profile",
          attributes: {
            email: customerEmail
          }
        }
      }
    }
  }
};

// create the event:
await eventsApi.createEvent(body);