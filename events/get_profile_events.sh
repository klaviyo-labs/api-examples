# this sample shell script retrieves all events for a specific profile. you can then use these events to power an activity feed.

# example 1: get all events for a specific profile. To use this request, set PROFILE_ID to the profile ID from your Klaviyo account.
# note that the filter is URL encoded.
PROFILE_ID='01G9ATZKKMSZMDB76EN6WVMVGM' 

curl --request GET \
     --url 'https://a.klaviyo.com/api/events?filter=equals%28profile_id%2C%27'$PROFILE_ID'%27%29' \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15'

# example 2: if you don't know the profile ID, you can use Get Profiles to find it. Set EMAIL_ADDRESS to the email address of the profile you want to retrieve events for.
EMAIL_ADDRESS='michaela.klaviyo@gmail.com'

PROFILE_DATA=$(curl --silent --request GET \
     --url "https://a.klaviyo.com/api/profiles?filter=equals(email,'$EMAIL_ADDRESS')" \
     --header "Authorization: Klaviyo-API-Key your-private-api-key" \
     --header "accept: application/vnd.api+json" \
     --header "revision: 2025-04-15")

PROFILE_ID=$(echo $PROFILE_DATA | jq -r '.data[0].id')

# now that we have the profile ID, we can get all events for this profile
curl --request GET \
     --url "https://a.klaviyo.com/api/events?filter=equals(profile_id,'$PROFILE_ID')" \
     --header "Authorization: Klaviyo-API-Key your-private-api-key" \
     --header "accept: application/vnd.api+json" \
     --header "revision: 2025-04-15"