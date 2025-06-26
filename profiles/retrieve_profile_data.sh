# this sample shell script retrieves profiles data, consent status, and predictive analytics.
# see https://developers.klaviyo.com/en/reference/get_profile and https://developers.klaviyo.com/en/reference/get_profiles for more information.

PRIVATE_API_KEY='your-private-api-key' # replace with your actual Klaviyo private API key that has read access to profiles.

# example 1: get all profile data for a specific profile.  
PROFILE_ID='YOUR_PROFILE_ID' # replace with the profile ID you want to retrieve

PROFILE=$(curl --request GET \
     --url "https://a.klaviyo.com/api/profiles/$PROFILE_ID" \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15')

# example 2: get profile data, including consent status and predictive analytics, for the same profile.
PROFILE_W_CONSENT_AND_ANALYTICS=$(curl --request GET \
     --url "https://a.klaviyo.com/api/profiles/$PROFILE_ID?additional-fields%5Bprofile%5D=subscriptions%2Cpredictive_analytics" \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15')

# example 3: if you don't know the profile ID, first use Get Profiles to find the profile by email. Then,  use Get Profile to retrieve profiles data
EMAIL_ADDRESS='CUSTOMER_EMAIL' # replace with the email address of the profile you want to update

# replace 'your-private-api-key' with your actual Klaviyo private API key that has read access to profiles.
PROFILE_DATA=$(curl --silent --request GET \
     --url "https://a.klaviyo.com/api/profiles?filter=equals(email,'$EMAIL_ADDRESS')" \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header "accept: application/vnd.api+json" \
     --header "revision: 2025-04-15")

NEW_PROFILE_ID=$(echo $PROFILE_DATA | jq -r '.data[0].id')

# now that we have the profile ID, we can get all profile data for this profile.
PROFILE_FROM_EMAIL=$(curl --request GET \
     --url "https://a.klaviyo.com/api/profiles/$NEW_PROFILE_ID?additional-fields%5Bprofile%5D=subscriptions%2Cpredictive_analytics" \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15')
