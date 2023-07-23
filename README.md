# Moonbase

![moonbase](public/planet.svg)

Moonbase is an ETL API for Amazon marketplace reports. Moonbase will process user reports and generate a normalised view of their Amazon sales performance.

Moonbase is a fairly straightforward Rails 7 application that makes use of Sidekiq, in order to perform much of the heavy lifting asynchronously.

## Prerequisites

Moonbase has been designed to run on [Heroku](https://heroku.com), however it can be used on any of the major cloud providers and even bare metal.

If you are new to Ruby/Rails, see [here](https://www.ruby-lang.org/en/documentation/installation) and [here](https://guides.rubyonrails.org/v6.0/getting_started.html).

The following services are required:

### Fixer

Fixer is used for obtaining live exchange rate data. Please register for an account [here](https://fixer.io) and generate an access token. A paid account is necessary, as the free one does not support HTTP nor USD. This is the value you will use for the environment variable `FIXER_ACCESS_KEY`.

### Sentry

If running Moonbase on Heroku, you can add Sentry [here](https://elements.heroku.com/addons/sentry). If not, signup for an account [here](https://sentry.io) and follow the onboarding steps to configure your first project and obtain a DSN. This is the value you will use for the environment variable `SENTRY_DSN` (if using Heroku, this will be setup automatically for you).

### AWS

Within your AWS account, create a new bucket to hold reports. This will be a bucket which users can upload to (via a signed URL). The bucket should not be open to the world. This is the value you will use for the environment variable `REPORTS_BUCKET`.

You will need to create a new IAM user on your AWS account and provide it with the appropriate permissions to write to the S3 bucket created above. See [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html) for further information on how to generate access credentials.

Use your newly generated credentials for the environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` respectively. Set `AWS_REGION` to the region where the bucket was created (e.g.: `us-east-1`).

### Memcachier

Report data is pushed into Memcachier (hosted Memcache) for fast retrieval. If running Moonbase on Heroku, this too can be easily added [here](https://elements.heroku.com/addons/memcachier). If not, signup for an account [here](https://www.memcachier.com/). Use the values generated for the environment variables `MEMCACHIER_SERVERS`, `MEMCACHIER_USERNAME` and `MEMCACHIER_PASSWORD` (if using Heroku, these will be setup automatically for you too).

## Endpoints

All endpoints require a token to be supplied in order to authenticate the request. Currently, this is handled by setting the `API_TOKEN` environment variable. While this approach is less than ideal, its envisaged that this will be replaced with a JWT solution before too long.

#### `GET /api/status`

---

Simple status ping. Returns a payload of:

```json
{
  "status": "ok"
}
```

&nbsp;

#### `PUT /api/v1/amazon/:amazon_marketplace_id/cost_of_goods/:amazon_cost_of_good_id`

---

Where:

| Parameter                   | Description                                                                        |
|-----------------------------|------------------------------------------------------------------------------------|
| `:amazon_marketplace_id`    | The Amazon marketplace ID (e.g. `A1F83G8C2ARO7P`)                                  |
| `:amazon_cost_of_good_id`   | A unique GUID for this cost of good (e.g. `6B29FC40-CA47-1067-B31D-00DD010662DA`). |

and takes an additional (required) payload of:

| Parameter                   | Description                                                  |
|-----------------------------|--------------------------------------------------------------|
| `:user_id`                  | The user GUID (e.g. `6B29FC40-CA47-1067-B31D-00DD010662DA`). |
| `:sku`                      | The SKU of the product.                                      |
| `:amount`                   | The amount of the cost of good.                              |
| `:date_time`                | The date and time that the cost was incurred.                |

If successful, the following response payload will be returned:

```json
{
  "success": "true"
}
```

&nbsp;

#### `GET /api/v1/amazon/marketplaces`

---

List of supported marketplaces. Returns a payload of:

```json
[
  {
    "amazon_marketplace_id": "b902b3d8-72e0-4d03-9e02-1bfcec97f8fc",
    "name": "amazon.com"
  },
  {
    "amazon_marketplace_id": "6bf3caa3-2b96-4724-b27f-f0ad57fe09b6",
    "name": "amazon.ca"
  },
  ...
]
```

&nbsp;

#### `GET /api/v1/amazon/reports/ingest/:user_id`

---

Where:

| Parameter                   | Description                                                  |
|-----------------------------|--------------------------------------------------------------|
| `:user_id`                  | The user GUID (e.g. `6B29FC40-CA47-1067-B31D-00DD010662DA`). |

If successful, an HTTP 200 status code will be returned.

&nbsp;

#### `GET /api/v1/currency/exchange_rates`

---

The response payload will be as follows:

```json

[
  {"currency_exchange_rate_id":"ac18d749-198f-46cf-9fb7-b16f53528a84","code":"USD","exchange_rate":"1.0"},
  {"currency_exchange_rate_id":"aa727325-1dc4-42b3-b077-54703f5e953b","code":"UYU","exchange_rate":"37.64"},
  ...
]

```

&nbsp;
#### `PUT /api/v1/expenses/others/:expenses_other_id`

---

Where:

| Parameter                   | Description                                                                        |
|-----------------------------|------------------------------------------------------------------------------------|
| `:expenses_other_id`        | A unique GUID for this expense (e.g. `6B29FC40-CA47-1067-B31D-00DD010662DA`).      |

and takes an additional (required) payload of:

| Parameter                     | Description                                                                    |
|-------------------------------|--------------------------------------------------------------------------------|
| `:currency_exchange_rate_id`  | The GUID of the exchange rate (e.g. `6B29FC40-CA47-1067-B31D-00DD010662DA`).   |
| `:user_id`                    | The user GUID (e.g. `6B29FC40-CA47-1067-B31D-00DD010662DA`).                   |
| `:amount`                     | The amount of the expense.                                                     |
| `:date_time`                  | The date/time that the expense was incurred.                                   |

If successful, the following response payload will be returned:

```json
{
  "success": "true"
}
```

## Setup

### Environment

Before running this project, please ensure that you have the following environment variables set, using the values from the services you setup earlier:

```bash
API_TOKEN=
AWS_ACCESS_KEY_ID=
AWS_DEFAULT_REGION=
AWS_SECRET_ACCESS_KEY=
DATABASE_URL=
DEFAULT_EMAIL=
FIXER_ACCESS_KEY=
MEMCACHIER_SERVERS=
MEMCACHIER_USERNAME=
MEMCACHIER_PASSWORD=
RAILS_ENV=development
RAILS_MASTER_KEY=
REPORTS_BUCKET=
SENTRY_DSN=
SIDEKIQ_ADMIN_PASSWORD=
```

## Development

### Linter

To run the linter:

```bash
make lint
```

### Tests

To run the tests and see test coverage:

```bash
make tests
```

## Sessions

Sidekiq makes use of Redis. To start a local Redis instance, run:

```bash
make docker-redis
```

## Cache

Memcache is used to cache frequently requested objects. To start a local Memcache instance, run:

```bash
make docker-memcache
```

## Database

This project makes use of Postgres.

### Setup

To start a local Postgres instance, run:

```bash
make docker-pg
```

Then, to create the database and apply the correct role:

```bash
make create-database
make create-user
```

### Migrations

To run migrations:

```bash
make migrate
```
