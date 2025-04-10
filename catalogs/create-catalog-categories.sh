curl --request POST \
     --url https://a.klaviyo.com/api/catalog-category-bulk-create-jobs \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-01-15' \
     --data '
{
    "data": {
        "type": "catalog-category-bulk-create-job",
        "attributes": {
            "categories": {
                "data": [
                    {
                        "type": "catalog-category",
                        "attributes": {
                            "integration_type": "$custom",
                            "catalog_type": "$default",
                            "external_id": "APPAREL",
                            "name": "Apparel"
                        }
                    },
                    {
                        "type": "catalog-category",
                        "attributes": {
                            "integration_type": "$custom",
                            "catalog_type": "$default",
                            "external_id": "FOOTWEAR",
                            "name": "Footwear"
                        }
                    }
                ]
            }
        }
    }
}
'
