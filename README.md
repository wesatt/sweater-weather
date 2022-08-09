# Sweater Weather API
This project was built as part of a final assessment for advancing to the next tier at [Turing School of Software and Design](https://turing.edu/).

The core goals of this project are to:
  - Expose an API that aggregates data from multiple external APIs
  - Expose an API that requires an authentication token
  - Expose an API for CRUD functionality
  - Determine completion criteria based on the needs of other developers
  - Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

Once the setup instructions below have been completed you will be able to make API calls to:
  - Retrieve precise weather info for a specified location
  - Register/create a user (also creates an API key that will be needed later)
  - Authenticate a user and retrieve that user's API key
  - Return a Json for a 'Road Trip' with origin, destination, time to destination, and weather for the anticipated arrival time at the destination


## Prereqs
Built with:
  - Ruby 2.7.4
  - Rails 5.2.8.1
  - RSpec 3.11

APIs used:
  - [OpenWeather Docs](https://openweathermap.org/api/one-call-3) [(Sign up for a free key here)](https://home.openweathermap.org/users/sign_up)
  - [MapQuest Docs](https://developer.mapquest.com/documentation) [(Sign up for a free key here)](https://developer.mapquest.com/user/login/sign-up)


## Setup
1. Ensure that you have the prerequisites or equivalent
2. Clone this repo and navigate to the root folder `cd sweater-weather`
3. Run `bundle install`
4. Run `bundle exec figaro install`
5. Open the file `./config/application.yml` and add the following lines into the file:
  ```ruby
  map_quest_api_key: your bare key goes here, no quotes
  open_weather_api_key: your bare key goes here, no quotes
  ```
6. Run `rails db:{drop,create,migrate,seed}`
7. (Optional) To run the test suite, run `bundle exec rspec`
8. Run `rails s`

You should now be able to hit the API endpoints using Postman or a similar tool.
Default host is `http://localhost:3000`


## Database Schema
![Database Schema Image](/images/sweater_weather_db_schema.png "Database Schema Image")


## Endpoints

### Retrieve Precise Weather Info
#### GET /api/v1/forecast
- Required Params
  - `location`
    - This can be in an address format or city/state. ex. 'denver,co',
- Example Request
  - `GET http://localhost:3000/api/v1/forecast?location=denver,co`
  ```ruby
  GET /api/v1/forecast?location=denver,co
  Content-Type: application/json
  Accept: application/json
  ```
- Example Response
  - Returns 5 days and 8 hours of weather data
  ```ruby
  {
      "data": {
          "id": null,
          "type": "forecast",
          "attributes": {
              "current_weather": {
                  "datetime": "2022-08-09T12:42:28-07:00",
                  "sunrise": "2022-08-09T06:11:03-07:00",
                  "sunset": "2022-08-09T19:49:03-07:00",
                  "temperature": 93.13,
                  "feels_like": 89.29,
                  "humidity": 19,
                  "uvi": 10.59,
                  "visibility": 10000,
                  "conditions": "few clouds",
                  "icon": "02d"
              },
              "daily_weather": [
                  {
                      "date": "2022-08-09",
                      "sunrise": "2022-08-09T06:11:03-07:00",
                      "sunset": "2022-08-09T19:49:03-07:00",
                      "max_temp": 94.14,
                      "min_temp": 74.43,
                      "conditions": "few clouds",
                      "icon": "02d"
                  }, ...
              ],
              "hourly_weather": [
                  {
                      "time": "12:00:00",
                      "temperature": 93.16,
                      "conditions": "few clouds",
                      "icon": "02d"
                  }, ...
              ]
          }
      }
  }
  ```

### Register/create a user (also creates an API key that will be needed later)
#### POST /api/v1/users
- Required Params
  - N/A (Send required data in the body of the request as displayed in the example below)
- Example Request
  - `POST http://localhost:3000/api/v1/users`
  ```ruby
  POST /api/v1/users
  Content-Type: application/json
  Accept: application/json

  body:
  {
    "email": "whatever@example.com",
    "password": "password",
    "password_confirmation": "password"
  }
  ```
- Example Response
  ```ruby
  {
      "data": {
          "id": 2,
          "type": "users",
          "attributes": {
              "email": "whatever@example.com",
              "api_key": "9d8832e4850362efbdc1a130f1f11ddf"
          }
      }
  }
  ```

### Authenticate a user and retrieve that user's API key
#### POST /api/v1/sessions
- Required Params
  - N/A (Send required data in the body of the request as displayed in the example below)
- Example Request
  - `POST http://localhost:3000/api/v1/sessions`
  ```ruby
  POST /api/v1/sessions
  Content-Type: application/json
  Accept: application/json

  body:
  {
    "email": "whatever@example.com",
    "password": "password"
  }
  ```
- Example Response
  ```ruby
  {
      "data": {
          "id": 2,
          "type": "users",
          "attributes": {
              "email": "whatever@example.com",
              "api_key": "9d8832e4850362efbdc1a130f1f11ddf"
          }
      }
  }
  ```


### Return a 'Road Trip' Json
#### POST /api/v1/road_trip
- Required Params
  - N/A (Send required data in the body of the request as displayed in the example below)
  - `POST http://localhost:3000/api/v1/road_trip`
  ```ruby
  POST /api/v1/road_trip
  Content-Type: application/json
  Accept: application/json

  body:
  {
    "origin": "Denver,CO",
    "destination": "Pueblo,CO",
    "api_key": "9d8832e4850362efbdc1a130f1f11ddf"
  }
  ```
- Example Response
  - Weather provided will be for the arrival time at the destination
  ```ruby
  {
      "data": {
          "id": null,
          "type": "roadtrip",
          "attributes": {
              "start_city": "denver,co",
              "end_city": "pueblo,co",
              "travel_time": "days: 0, hours: 1, minutes: 45",
              "weather_at_eta": {
                  "temperature": 90.45,
                  "conditions": "clear sky"
              }
          }
      }
  }
  ```
