curl --request POST \
     --url https://a.klaviyo.com/client/events?company_id=Y8LNjW \
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