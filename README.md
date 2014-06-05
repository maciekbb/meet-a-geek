# API description

method | URI Pattern | Controller#Action | description
---|---|---|---
GET | /matches(.:format) | users#matches | potential matches
GET | /users/:id/avatar(.:format) | users#avatar | download user's avatar (works only if they are able to meet)
POST | /user(.:format) | users#create | create an user, returns user token, the only method which doesn't require token authorization
PATCH | /user(.:format) | users#update | update user's data (like name, avatar or coordinates)
DELETE | /user(.:format) | users#destroy | doing nothing for now
GET | /tags(.:format) | tags#index | get current users's tags
PATCH | /tag(.:format) | tags#update | update tags
POST | /invitations/invite(.:format) | invitations#invite | creates an invitation
PATCH | /invitations/accept(.:format) | invitations#accept | accepts an invitation
PATCH | /invitations/reject(.:format) | invitations#reject | rejects an invitation
GET | /invitations/incoming_invitations(.:format) | invitations#incoming_invitations | fetch incoming invitations
GET | /invitations/outcoming_invitations(.:format) | invitations#outcoming_invitations | fetch outcoming invitatios

# Http Queries with Returned JSONs

* HTTP.GET - /matches(.:format)
```json
{
    "users": [
        {
            "id": {
                "$oid": "5390d1343662360002040000"
            },
            "name": "Maciek"
        },
        {
            "id": {
                "$oid": "5390d3353265380002010000"
            },
            "name": "Krzysiu"
        }
    ]
}
```

* HTTP.POST - /user(.:format)
  
```json
{
    "id": {
        "$oid": "538f84183661650002190000"
    },
    "name": "UserName",
    "auth_token": "e167104a12af9a8fbbafb3332f6559be"
}
```

* HTTP.PATCH - /user(.:format)
```
user[coordinate_attributes][location][]=(longitude)
user[coordinate_attributes][location][]=(latitude)
```
---
```json
{
    "id": {
        "$oid": "538f84183661650002190000"
    },
    "name": "Muuuucka"
}
```

* HTTP.GET - /tags(.:format)
```json
{
    "tags": [
        {
            "tags": {
                "_id": {
                    "$oid": "5390cdd03662360002010000"
                },
                "name": "java",
                "user_ids": [
                    {
                        "$oid": "5390ccde3662360002000000"
                    },
                ]
            }
        },
        {
            "tags": {
                "_id": {
                    "$oid": "5390cdd03662360002020000"
                },
                "name": "c++",
                "user_ids": [
                    {
                        "$oid": "5390ccde3662360002000000"
                    },
                    {
                        "$oid": "5390d3353265380002010000"
                    },
                    {
                        "$oid": "5390d5193265380002030000"
                    },
                ]
            }
        }
    ]
}
```

* HTTP.PATCH - /tag
```
tags[]=tagString
tags[]=tagString
tags[]=tagString
.
.
.
```
---
```
Nic nie zwraca
```

* HTTP.POST - /invitations/invite(.:format)
```
user_id=538faa9c3661650002580000
message=InvitationMessage
```
---
```json
{
    "_id": {
        "$oid": "538faac936616500025a0000"
    },
    "accepted": null,
    "from_id": {
        "$oid": "538f84183661650002190000"
    },
    "message": "asdflajsdflkajsf",
    "rejected": null,
    "to_id": {
        "$oid": "538faa9c3661650002580000"
    }
}
```

* HTTP.GET - /invitations/outcoming_invitations(.:format)
```json
{
    "invitations": [
        {
            "invitations": {
                "_id": {
                    "$oid": "538faaba3661650002590000"
                },
                "accepted": null,
                "from_id": {
                    "$oid": "538f84183661650002190000"
                },
                "message": null,
                "rejected": null,
                "to_id": {
                    "$oid": "538faa9c3661650002580000"
                }
            }
        },
        {
            "invitations": {
                "_id": {
                    "$oid": "538faac936616500025a0000"
                },
                "accepted": null,
                "from_id": {
                    "$oid": "538f84183661650002190000"
                },
                "message": "asdflajsdflkajsf",
                "rejected": null,
                "to_id": {
                    "$oid": "538faa9c3661650002580000"
                }
            }
        }
    ]
}
```

* HTTP.GET - /invitations/incoming_invitations(.:format)
```
To samo co w outcoming
```

* HTTP.PATCH - /invitations/accept(.:format)
```
invitation_id=538fb13b3661650002690000
```
---
```
Nic nie zwraca
```

* HTTP.PATCH - /invitations/reject(.:format)
```
invitation_id=538fb13b3661650002690000
```
---
```
Nic nie zwraca
```

# Usage example

Please take a look at `spec/controllers` directory for all common usage examples.
