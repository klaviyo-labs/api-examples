# this sample Python code creates and updates a customer profile in Klaviyo.
# for more information on the Create or Update Profile endpoint, see https://developers.klaviyo.com/en/reference/create_or_update_profile
import os
from klaviyo_api import KlaviyoAPI

# load your private API key from environment variables. 
# ensure you have set the environment variable "private_api_key" with Klaviyo private API key that has write access to profiles. 
private_api_key = os.environ.get("private_api_key")

# instantiate the KlaviyoAPI client with your private API key.
klaviyo = KlaviyoAPI(private_api_key)

# example 1: create a profile with email, first name, location, and Favorite coffee flavor properties.
# the Create or Update Profile endpoint will create a new profile if it does not exist, or update the existing profile if it does.

customer_email = "customer email"  # replace with the email of the profile you want to create
first_name = "customer first name"  # replace with the first name of the profile you want to create
city = "customer city"  # replace with the city of the profile you want to create
favorite_coffee_flavor = "customer favorite coffee flavor"  # replace with the favorite coffee flavor of the profile you want to create

# create the profile with the specified attributes
body = {
    "data": {
        "type": "profile",
        "attributes": {
            "email": customer_email,
            "first_name": first_name,
            "location": {
                "city": city
            },
            "properties": {
                "Favorite coffee flavor": favorite_coffee_flavor
            }
        }
    }
}

# klaviyo.Profiles.create_or_update_profile(body)

# example 2: update the profile with a new value for Favorite coffee flavor and a new property for Roast preference.

new_favorite_coffee_flavor = "hazelnut"  # replace with the new favorite coffee flavor
new_roast_preference = "medium roast"  # replace with the new roast preference

# replace with the new favorite coffee flavor and roast preference
updated_body = {
    "data": {
        "type": "profile",
        "attributes": {
            "email": customer_email,
            "properties": {
                "Favorite coffee flavor": new_favorite_coffee_flavor,
                "Roast preference": new_roast_preference
            }
        }
    }
}

klaviyo.Profiles.create_or_update_profile(updated_body)