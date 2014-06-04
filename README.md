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
* 


# Usage example

Please take a look at `spec/controllers` directory for all common usage examples.
