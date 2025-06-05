import requests
import os
from klaviyo import KlaviyoAPI

private_key = os.environ["private_key"]
klaviyo = KlaviyoAPI(private_key)

body = {
    "data": {
        "type": "event",
        "attributes": {
            "properties": {
                "Seminar name": "Coffee sustainability",
                "Seminar date": "2025-02-09"
            },
            "metric": {
                "data": {
                    "type": "metric",
                    "attributes": {
                        "name": "Registered for seminar"
                    }
                }
            },
            "profile": {
                "data": {
                    "type": "profile",
                    "attributes": {
                        "email": "michaela@gmail.com",
                        "location": {
                            "zip": "12345"
                        }
                    }
                }
            }
        }
    }
}

klaviyo.Events.create_event(body)