# Lunch and Learn

## Table of Contents

- [Description](#description)
- [Technical Details](#technical-details)
- [Getting Started](#getting-started)
  - [Local Installation](#local-installation)
  - [Endpoints](#endpoints)
  - [RSpec Suite](#rspec-suite)
- [Authors \& Acknowledgments](#authors--acknowledgments)

## Description

Lunch and Learn is a backend API service which provides various types of food and culture information on a user-specified country.  It was created to satisfy the requirements for a Mod 3 solo project at the [Turing School of Software and Design](https://turing.edu/).  Project requirements can be found [here](https://backend.turing.edu/module3/projects/lunch_and_learn/requirements).

## Technical Details

This application is built with Ruby on Rails and tested with RSpec.  API endpoint data is returned in json.

Lunch and Learn aggregates data from several external APIs:
- [REST Countries](https://restcountries.com/)
- [Edamam Recipe Search](https://developer.edamam.com/edamam-recipe-api)
- [Youtube](https://developers.google.com/youtube/v3) (specifically the [Mr. History channel](https://www.youtube.com/channel/UCluQ5yInbeAkkeCndNnUhpw))
- [Unsplash](https://unsplash.com/developers)
- [Geoapify Places](https://www.geoapify.com/places-api)

## Getting Started

### Local Installation

1. Clone the repo

```
git clone git@github.com:dlayton66/lunch_and_learn.git
```

2. Install gems
```
bundle install
```

3. Install figaro
```
bundle exec figaro install
```

4. Add external API keys to these environment variables in `application.yml`.  All APIs require signup except for REST Countries.
```
# Edamam
APP_ID: 
APP_KEY: 

# Geoapify Places
PLACES_API_KEY: 

# YouTube
YOUTUBE_API_KEY:

# Unsplash
UNSPLASH_ACCESS_KEY:
```

5. Create database and run migrations
```
rails db:{create,migrate}
```

6. Run rails server
```
rails server
```

7. Call the [endpoints](#endpoints) from your favorite API platform (e.g. [Postman](https://www.postman.com/))

### Endpoints

1. Get recipes for a particular country
```
GET http://localhost:3000/api/v1/recipes?country=thailand
```

2. Get learning resources for a particular country
```
GET http://localhost:3000/api/v1/learning_resources?country=thailand
```

3. Get tourist sights for a particular country
```
GET http://localhost:3000/api/v1/tourist_sights?country=thailand
```

4. User registration (user api_key sent in response)
```
POST http://localhost:3000/api/v1/users
Content-Type: application/json
Accept: application/json

{
  "name": "Name",
  "email": "name@email.com",
  "password": "password123",
  "password_confirmation": "password123"
}
```

5. User login (user api_key sent in response)
```
POST http://localhost:3000/api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "name@email.com",
  "password": "password123"
}
```

6. Add favorite for user
```
POST http://localhost:3000/api/v1/favorites
Content-Type: application/json
Accept: application/json

{
    "api_key": "jgn983hy48thw9begh98h4539h4",
    "country": "Thailand",
    "recipe_link": "https://www.tastingtable.com/...",
    "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
}
```

7. Get a user's favorites
```
GET /api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h4
```

### RSpec Suite

Run the entire spec suite

```
bundle exec rspec spec/
```

All tests should be passing.

## Authors & Acknowledgments

:bust_in_silhouette: **Drew Layton** 
- dlayton66@gmail.com
- [GitHub](https://github.com/dlayton66)
- [LinkedIn](https://www.linkedin.com/in/drew-layton/)
