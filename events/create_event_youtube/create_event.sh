# sample cURL request to the Create Event endpoint. This code is used in the Set up a custom catalog in Klaviyo YouTube video: https://www.youtube.com/watch?v=ksvZ5Kdvf8o
curl --request POST \
     --url https://a.klaviyo.com/api/events \
     --header 'Authorization: Klaviyo-API-Key your-private-api-key' \
     --header 'accept: application/vnd.api+json' \
     --header 'content-type: application/vnd.api+json' \
     --header 'revision: 2025-04-15' \
     --data '
{
    "data": {
        "type": "event",
        "attributes": {
            "properties": {
                "Makeup type": "wedding",
                "Makeup style": "natural",
                "Appointment date": "2025-09-07"
            },
            "value": 100,
            "value_currency": "USD",
            "metric": {
                "data": {
                    "type": "metric",
                    "attributes": {
                        "name": "Booked makeup appointment"
                    }
                }
            },
            "profile": {
                "data": {
                    "type": "profile",
                    "attributes": {
                        "properties": {
                            "email": "michaela.klaviyo@gmail.com"
                        }
                    }
                }
            }
        }
    }
}
'
