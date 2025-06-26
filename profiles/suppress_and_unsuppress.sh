# this sample shell script suppresses and unsuppresses profiles in Klaviyo.
# for more information, see https://developers.klaviyo.com/en/reference/bulk_suppress_profiles and https://developers.klaviyo.com/en/reference/bulk_unsuppress_profiles.

PRIVATE_API_KEY='your-private-api-key' # replace with your actual Klaviyo private API key that has write access to profiles and subscriptions.

# example 1: suppress a profile.
CUSTOMER_EMAIL='customer-email-to-suppress' # replace with the actual profile ID you want to suppress.

curl --request POST \
     --url 'https://a.klaviyo.com/api/profile-suppression-bulk-create-jobs' \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --header 'Content-Type: application/vnd.api+json' \
     --data @- <<EOF
{
  "data": {
    "type": "profile-suppression-bulk-create-job",
    "attributes": {
      "profiles": {
        "data": [
          {
            "type": "profile",
            "attributes": {
              "email": "$CUSTOMER_EMAIL"
            }
          }
        ]
      }
    }
  }
}
EOF

# example 2: suppress all profiles in a specific list. 
LIST_ID='list-id-to-suppress' # replace with the actual list ID you want to suppress the profile from.

curl --request POST \
     --url 'https://a.klaviyo.com/api/profile-suppression-bulk-create-jobs' \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'Content-Type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data @- <<EOF
{
    "data": {
        "type": "profile-suppression-bulk-create-job",
        "attributes": {},
        "relationships": {
            "list": {
                "data": {
                    "type": "list",
                    "id": "$LIST_ID"
                }
            }
        }
    }
}
EOF


# example 3: unsuppress 2 profiles.
# note that this will only remove suppressions with reason USER_SUPPRESSED. Unsubscribed profiles and suppressed profiles for other reasons will not be affected.
FIRST_EMAIL_TO_UNSUPPRESS='first-customer-email-to-unsuppress' # replace with the email of the first profile you want to unsuppress.
SECOND_EMAIL_TO_UNSUPPRESS='second-customer-email-to-unsuppress' # replace with the email of the second profile you want to unsuppress.

curl --request POST \
     --url 'https://a.klaviyo.com/api/profile-suppression-bulk-delete-jobs' \
     --header "Authorization: Klaviyo-API-Key $PRIVATE_API_KEY" \
     --header 'accept: application/vnd.api+json' \
     --header 'Content-Type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data @- <<EOF
{
  "data": {
    "type": "profile-suppression-bulk-delete-job",
    "attributes": {
      "profiles": {
        "data": [
          {
            "type": "profile",
            "attributes": {
              "email": "$FIRST_EMAIL_TO_UNSUPPRESS"
            }
          },
          {
            "type": "profile",
            "attributes": {
              "email": "$SECOND_EMAIL_TO_UNSUPPRESS"
            }
          }
        ]
      }
    }
  }
}
EOF