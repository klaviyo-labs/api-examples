curl --request POST \
     --url https://a.klaviyo.com/api/back-in-stock-subscriptions \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-01-15' \
     --data '
{
	"data": {
		"type": "back-in-stock-subscription",
		"attributes": {
			"channels": [
				"EMAIL"
			],
			"profile": {
				"data": {
					"type": "profile",
					"attributes": {
						"email": "michaela.klaviyo@gmail.com"
					}
				}
			}
		},
		"relationships": {
			"variant": {
				"data": {
					"type": "catalog-variant",
					"id": "$custom:::$default:::bomber123-s"
				}
			}
		}
	}
}
'