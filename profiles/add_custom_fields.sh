# this sample shell script adds custom fields to a profile that can be used for segmentation, flows, and template personalization.
# see https://developers.klaviyo.com/en/reference/update_profile for more details.

PRIVATE_API_KEY='your-private-api-key' # replace with your actual Klaviyo private API key that has write access to profiles.

# example 1: Update a profile with custom fields
PROFILE_ID='YOUR_PROFILE_ID' # replace with the profile ID you want to update

# define custom fields to add or update
CUSTOM_FIELDS="{\"Favorite Color\": \"Blue\", \"Loyalty Member\": true, \"Last Purchase Date\": \"2023-10-01\", \"Total Spend\": 150.75}"

# replace 'your-private-api-key' with your actual Klaviyo private API key that has write access to profiles.
curl --request PATCH \
     --url https://a.klaviyo.com/api/profiles/$PROFILE_ID \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data "
{
     \"data\": {
          \"type\": \"profile\",
          \"id\": \"$PROFILE_ID\",
          \"attributes\": {
               \"properties\": $CUSTOM_FIELDS
          }
     }
}
"

# example 2: if you don't know the profile ID, you can use Get Profiles to find it. Set EMAIL_ADDRESS to the email address of the profile you want to retrieve events for.
EMAIL_ADDRESS='CUSTOMER_EMAIL' # replace with the email address of the profile you want to update

# replace 'your-private-api-key' with your actual Klaviyo private API key that has read access to profiles.
PROFILE_DATA=$(curl --silent --request GET \
     --url "https://a.klaviyo.com/api/profiles?filter=equals(email,'$EMAIL_ADDRESS')" \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header "accept: application/vnd.api+json" \
     --header "revision: 2025-04-15")

NEW_PROFILE_ID=$(echo $PROFILE_DATA | jq -r '.data[0].id')

# now that we have the profile ID, we can update it with custom fields. Note that this uses the same custom fields as example 1.
curl --request PATCH \
     --url https://a.klaviyo.com/api/profiles/$NEW_PROFILE_ID \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY"\
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data "
{
     \"data\": {
          \"type\": \"profile\",
          \"id\": \"$NEW_PROFILE_ID\",
          \"attributes\": {
               \"properties\": $CUSTOM_FIELDS
          }
     }
}
"