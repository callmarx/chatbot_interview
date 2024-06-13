# Chatbot Interview

This repository contains the code for the technical test for the Software Engineer position at Plaza.
The application is a simple chatbot interface that interacts with potential job applicants using the OpenAI API.

## Technical Info
This projet use this tools:
- Docker
- Ruby 3.2.2
- Rails 7.1.3.4
- PostgreSQL 16
- Redis 7

## Executing on your machine

Create `.env` file. Something like:
```
OPENAI_API_KEY=<your-openai-api-key>
OPENAI_API_URL="https://api.openai.com/v1/chat/completions"
MODEL="gpt-4o"
TEMPERATURE=0.1
MAX_TOKENS=3000
TOP_P=1
FREQUENCY_PENALTY=2
PRESENCE_PENALTY=2
```

PostgreSQL and Redis is dockerized, so you need a docker compose installed. 
```sh
docker compose up
```

Create the database and migrations in the first setup
```sh
bundle exec rails db:create db:migrate
```

Run Rails with Procfile
```sh
./bin/dev
```

## Notes
Unfortunately, I did not have enough time to develop tests for this application.

Some implementations are simplified to meet the project deadline. Specifically, look for the line commented with:
```
## NOTE: this is not a correct approach in a formal Rails application. It was used to speed up development.
```
