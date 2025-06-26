# this sample shell script creates and subsequently updates a profile.
# for more information on the Create or Update Profile endpoint, see https://developers.klaviyo.com/en/reference/create_or_update_profile

PRIVATE_API_KEY='your-private-api-key' # replace with your actual Klaviyo private API key that has write access to profiles.

# example 1: create a profile with email, first name, location, and Favorite coffee flavor properties.
# the Create or Update Profile endpoint will create a new profile if it does not exist, or update the existing profile if it does

CUSTOMER_EMAIL='customer email' # replace with the email of the profile you want to create
FIRST_NAME='customer first name' # replace with the first name of the profile you want to create
CITY='customer city' # replace with the city of the profile you want to create
FAVORITE_COFFEE_FLAVOR='customer favorite coffee flavor' # replace with the favorite coffee flavor of the profile you want to create

# create the profile with the specified attributes
curl --request POST \
     --url https://a.klaviyo.com/api/profile-import \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data @- <<EOF
{
    "data": {
        "type": "profile",
        "attributes": {
            "email": "$CUSTOMER_EMAIL",
            "first_name": "$FIRST_NAME",
            "location": {
                "city": "$CITY"
            },
            "properties": {
                "Favorite coffee flavor": "$FAVORITE_COFFEE_FLAVOR"
            }
        }
    }
}
EOF

# example 2: update the profile with a new property, Roast preference, and update the Favorite coffee flavor property.

NEW_FAVORITE_COFFEE_FLAVOR='new favorite coffee flavor' # replace with the new favorite coffee flavor of the profile you want to update
NEW_ROAST_PREFERENCE='new roast preference' # replace with the new roast preference of the profile you want to update

# update the profile with a new value for Favorite coffee flavor and a new property for Roast preference.
curl --request POST \
     --url https://a.klaviyo.com/api/profile-import \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data @- <<EOF
{
    "data": {
        "type": "profile",
        "attributes": {
            "email": "$CUSTOMER_EMAIL",
            "properties": {
                "Favorite coffee flavor": "$NEW_FAVORITE_COFFEE_FLAVOR",
                "Roast preference": "$NEW_ROAST_PREFERENCE"
            }
        }
    }
}
EOF