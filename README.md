# Frontapp

Ruby client to work with Frontapp API (https://dev.frontapp.com)

## Installation

```Bash
gem install frontapp
```

## Usage

The auth_token can be obtained from Frontapp, in Settings -> API & Integrations -> API

Create a Frontapp client
```ruby
require 'frontapp'
client = Frontapp::Client.new(auth_token: 'token') 
```

### Tags
```ruby
# list all tags
client.tags

# get specific tag
tag = client.get_tag("tag_55c8c149")

# create tag
result = client.create_tag!({name: "New tag name"})

# get all conversation for a tag
conversations = client.get_tag_conversations("tag_55c8c149")
```