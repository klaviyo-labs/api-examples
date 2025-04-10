curl --request POST \
     --url https://a.klaviyo.com/api/catalog-item-bulk-create-jobs \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-01-15' \
     --data '
{
    "data": {
        "type": "catalog-item-bulk-create-job",
        "attributes": {
            "items": {
                "data": [
                    {
                        "type": "catalog-item",
                        "attributes": {
                            "external_id": "bomber123",
                            "title": "Bomber Jacket",
                            "description": "This classic, stylish piece that effortlessly merges modern design with timeless appeal. Zip-up front closure and pockets along the sides provide both functionality and style. This versatile piece is perfect for adding a chic, urban touch to any outfit.",
                            "url": "https://www.mystore.com/shop/outerwear/jackets/bomber-jacket",
                            "integration_type": "$custom",
                            "price": 50.00,
                            "catalog_type": "$default",
                            "image_full_url": "https://images.unsplash.com/photo-1591047139829-d91aecb6caea?q=80&w=1472&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            "published": true
                        },
                        "relationships": {
                            "categories": {
                                "data": [
                                    {
                                        "type": "catalog-category",
                                        "id": "$custom:::$default:::APPAREL"
                                    }
                                ]
                            }
                        }
                    },
                    {
                        "type": "catalog-item",
                        "attributes": {
                            "external_id": "boots123",
                            "title": "Brown Leather Boots",
                            "description": "These high-ankle boots blend rugged durability with contemporary style. Made from high-quality leather, they feature a matte finish that complements their sturdy construction.Perfect for adding a bold statement to any outfit, these versatile boots are ideal for both urban adventures and outdoor excursions.",
                            "url": "https://www.mystore.com/shop/shoes/boots/brown-leather-boots",
                            "integration_type": "$custom",
                            "price": 89.99,
                            "catalog_type": "$default",
                            "image_full_url": "https://images.unsplash.com/photo-1605733160314-4fc7dac4bb16?q=80&w=1490&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            "published": true
                        },
                        "relationships": {
                            "categories": {
                                "data": [
                                    {
                                        "type": "catalog-category",
                                        "id": "$custom:::$default:::FOOTWEAR"
                                    }
                                ]
                            }
                        }
                    },
                    {
                        "type": "catalog-item",
                        "attributes": {
                            "external_id": "sandals123",
                            "title": "Chunky Sandals",
                            "description": "These chunky sandals are perfect for those who embrace a blend of comfort and style. Featuring a robust platform sole, these sandals offer both height and support, making them ideal for all-day wear. The sleek leather and the chunky sole create a contemporary aesthetic, suitable for both casual outings and more adventurous fashion endeavors.",
                            "url": "https://www.mystore.com/shop/shoes/sandals/chunky-sandals",
                            "integration_type": "$custom",
                            "price": 29.99,
                            "catalog_type": "$default",
                            "image_full_url": "https://images.unsplash.com/photo-1562273138-f46be4ebdf33?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            "published": true
                        },
                        "relationships": {
                            "categories": {
                                "data": [
                                    {
                                        "type": "catalog-category",
                                        "id": "$custom:::$default:::FOOTWEAR"
                                    }
                                ]
                            }
                        }
                    }
                ]
            }
        }
    }
}
'
