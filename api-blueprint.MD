url = 'localhost:3000'
+ Request
	GET '/currency'
+ Response
	[
    {
        "id": 1,
        "from": "gbp",
        "to": "gbb",
        "created_at": "2019-05-20T04:14:19.000Z",
        "updated_at": "2019-05-20T15:43:32.000Z"
    },
    {
        "id": 2,
        "from": "asd",
        "to": "ada",
        "created_at": "2019-05-20T05:49:16.000Z",
        "updated_at": "2019-05-20T05:49:20.000Z"
    },
    {
        "id": 3,
        "from": "USD",
        "to": "GBP",
        "created_at": "2019-05-20T14:36:30.000Z",
        "updated_at": "2019-05-20T14:36:30.000Z"
    },
    {
        "id": 4,
        "from": "da",
        "to": "da",
        "created_at": "2019-05-20T14:39:29.000Z",
        "updated_at": "2019-05-20T14:39:29.000Z"
    }
]

+ Request
	PATCH '/currency/:id'
+ Response
	{
        "id": 4,
        "from": "da",
        "to": "da",
        "created_at": "2019-05-20T14:39:29.000Z",
        "updated_at": "2019-05-20T14:39:29.000Z"
    	}

+ Request
	DELETE '/currency/:id'

+ Response
	{
	  status: 200
	}

+ Request
	GET '/currency/:id'
+ Response
	{
	    "id": 1,
	    "from": "gbp",
	    "to": "gbb",
	    "created_at": "2019-05-20T04:14:19.000Z",
	    "updated_at": "2019-05-20T15:43:32.000Z"
	}

+ Request
	POST '/currency',
	params : 
	{
		"from" : "USD",
		"to" : "GBP"
	}
+ Response
	+ 200

+ Request
	GET '/history/index/:date'

+ Response 
	[
    {
        "currency": {
            "id": 1,
            "from": "gbp",
            "to": "gbb",
            "created_at": "2019-05-20T04:14:19.000Z",
            "updated_at": "2019-05-20T15:43:32.000Z"
        },
        "average": 18.249
    },
    {
        "currency": {
            "id": 2,
            "from": "asd",
            "to": "ada",
            "created_at": "2019-05-20T05:49:16.000Z",
            "updated_at": "2019-05-20T05:49:20.000Z"
        },
        "average": "Insuficient data"
    },
    {
        "currency": {
            "id": 3,
            "from": "USD",
            "to": "GBP",
            "created_at": "2019-05-20T14:36:30.000Z",
            "updated_at": "2019-05-20T14:36:30.000Z"
        },
        "average": "Insuficient data"
    },
    {
        "currency": {
            "id": 4,
            "from": "da",
            "to": "da",
            "created_at": "2019-05-20T14:39:29.000Z",
            "updated_at": "2019-05-20T14:39:29.000Z"
        },
        "average": "Insuficient data"
    }
]

+ Request
	GET '/history/:id'

+ Response
	{
	    "rates": [
		{
		    "id": 1,
		    "exchangeable_currency_id": 1,
		    "date": "2019-05-20",
		    "rate": 1.21,
		    "created_at": "2019-05-20T04:14:45.000Z",
		    "updated_at": "2019-05-20T04:14:47.000Z"
		},
		{
		    "id": 2,
		    "exchangeable_currency_id": 1,
		    "date": "2019-05-19",
		    "rate": 121,
		    "created_at": "2019-05-20T04:15:01.000Z",
		    "updated_at": "2019-05-20T04:15:03.000Z"
		},
		{
		    "id": 3,
		    "exchangeable_currency_id": 1,
		    "date": "2019-05-18",
		    "rate": 1.22,
		    "created_at": "2019-05-20T04:17:29.000Z",
		    "updated_at": "2019-05-20T04:17:32.000Z"
		},
		{
		    "id": 4,
		    "exchangeable_currency_id": 1,
		    "date": "2019-05-17",
		    "rate": 1.11,
		    "created_at": "2019-05-20T04:17:44.000Z",
		    "updated_at": "2019-05-20T04:17:47.000Z"
		},
		{
		    "id": 5,
		    "exchangeable_currency_id": 1,
		    "date": "2019-05-16",
		    "rate": 1.1,
		    "created_at": "2019-05-20T04:17:58.000Z",
		    "updated_at": "2019-05-20T04:18:00.000Z"
		},
		{
		    "id": 6,
		    "exchangeable_currency_id": 1,
		    "date": "2019-05-15",
		    "rate": 1,
		    "created_at": "2019-05-20T04:18:11.000Z",
		    "updated_at": "2019-05-20T04:18:13.000Z"
		},
		{
		    "id": 7,
		    "exchangeable_currency_id": 1,
		    "date": "2019-05-14",
		    "rate": 1.1,
		    "created_at": "2019-05-20T04:18:25.000Z",
		    "updated_at": "2019-05-20T04:18:27.000Z"
		}
	    ],
	    "average": 18.249,
	    "variance": 120
	}

+ Request
	POST '/history/'
	{
		"rate" : 1.2,
		"exchangeable_currency_id": 1,
		"date": "2019-05-21"
	}
+ Response
	{
	    "id": 11,
	    "exchangeable_currency_id": 1,
	    "date": "2019-05-21",
	    "rate": 1.2,
	    "created_at": "2019-05-20T15:54:59.000Z",
	    "updated_at": "2019-05-20T15:54:59.000Z"
	}

	
