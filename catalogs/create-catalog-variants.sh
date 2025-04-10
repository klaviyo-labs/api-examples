curl --request POST \
     --url https://a.klaviyo.com/api/catalog-variant-bulk-create-jobs \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-01-15' \
     --data '
{
	"data": {
		"type": "catalog-variant-bulk-create-job",
		"attributes": {
			"variants": {
				"data": [
					{
						"type": "catalog-variant",
						"attributes": {
							"external_id": "bomber123-s",
							"title": "Bomber Jacket - Small",
							"description": "This classic, stylish piece that effortlessly merges modern design with timeless appeal. Zip-up front closure and pockets along the sides provide both functionality and style. This versatile piece is perfect for adding a chic, urban touch to any outfit.",
							"sku": "BJS456371",
							"inventory_quantity": 10,
							"price": 50.00,
							"url": "https://www.mystore.com/shop/outerwear/jackets/bomber-jacket/bomber123-s",
							"catalog_type": "$default",
							"integration_type": "$custom",
							"image_full_url": "https://images.unsplash.com/photo-1591047139829-d91aecb6caea?q=80&w=1472&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
							"published": true
						},
						"relationships": {
							"item": {
								"data": {
									"type": "catalog-item",
									"id": "$custom:::$default:::bomber123"
								}
							}
						}
					},
          {
						"type": "catalog-variant",
						"attributes": {
							"external_id": "bomber123-m",
							"title": "Bomber Jacket - Medium",
							"description": "This classic, stylish piece that effortlessly merges modern design with timeless appeal. Zip-up front closure and pockets along the sides provide both functionality and style. This versatile piece is perfect for adding a chic, urban touch to any outfit.",
							"sku": "BJS456372",
							"inventory_quantity": 10,
							"price": 50,
							"url": "https://www.mystore.com/shop/outerwear/jackets/bomber-jacket/bomber123-s",
							"catalog_type": "$default",
							"integration_type": "$custom",
							"image_full_url": "https://images.unsplash.com/photo-1591047139829-d91aecb6caea?q=80&w=1472&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
							"published": true
						},
						"relationships": {
							"item": {
								"data": {
									"type": "catalog-item",
									"id": "$custom:::$default:::bomber123"
								}
							}
						}
					},
          {
						"type": "catalog-variant",
						"attributes": {
							"external_id": "bomber123-l",
							"title": "Bomber Jacket - Large",
							"description": "This classic, stylish piece that effortlessly merges modern design with timeless appeal. Zip-up front closure and pockets along the sides provide both functionality and style. This versatile piece is perfect for adding a chic, urban touch to any outfit.",
							"sku": "BJS456373",
							"inventory_quantity": 10,
							"price": 50,
							"url": "https://www.mystore.com/shop/outerwear/jackets/bomber-jacket/bomber123-s",
							"catalog_type": "$default",
							"integration_type": "$custom",
							"image_full_url": "https://images.unsplash.com/photo-1591047139829-d91aecb6caea?q=80&w=1472&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
							"published": true
						},
						"relationships": {
							"item": {
								"data": {
									"type": "catalog-item",
									"id": "$custom:::$default:::bomber123"
								}
							}
						}
					}
				]
			}
		}
	}
}
'
