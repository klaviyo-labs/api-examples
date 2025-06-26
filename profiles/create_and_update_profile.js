// this sample JavaScript code creates and updates a customer profile in Klaviyo.
// for more information on the Create or Update Profile endpoint, see https://developers.klaviyo.com/en/reference/create_or_update_profile

import { ApiKeySession, ProfilesApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have write access to profiles.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

// instantiate the API session and profiles API
const session = new ApiKeySession(apiKey)
const profilesApi = new ProfilesApi(session)

// example 1: create a profile with email, first name, location, and Favorite coffee flavor properties.
// the Create or Update Profile endpoint will create a new profile if it does not exist, or update the existing profile if it does.
const customerEmail = "Customer Email" // replace with the email of the profile you want to create
const firstName = "Customer First Name" // replace with the first name of the profile you want to create
const city = "Customer City" // replace with the city of the profile you want to create
const favoriteCoffeeFlavor = "Customer Favorite Coffee Flavor" // replace with the favorite coffee flavor of the profile you want to create

// create the profile with the specified attributes
const body = {
    data: {
        type: "profile",
        attributes: {
            email: customerEmail,
            location: {
                city: city
            },
            properties: {
                "Favorite coffee flavor": favoriteCoffeeFlavor,
                "first_name": firstName 
            }
        }
    }
}

// await profilesApi.createOrUpdateProfile(body);

// example 2: update the profile you just created with a new value for Favorite coffee flavor and a new property for Roast preference.
const newFavoriteCoffeeFlavor = "hazelnut" // replace with the new favorite coffee flavor
const roastPreference = "medium" // replace with the roast preference you want to add

// update the profile with the specified attributes
const updateBody = {
    data: {
        type: "profile",
        attributes: {
            email: customerEmail,
            properties: {
                "Favorite coffee flavor": newFavoriteCoffeeFlavor,
                "Roast preference": roastPreference
            }
        }
    }
}

await profilesApi.createOrUpdateProfile(updateBody);