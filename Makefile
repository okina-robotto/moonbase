lint:
	@rubocop

tests:
	RAILS_ENV=test bundle exec rspec

docker-pg:
	@docker-compose -f ./docker-compose.yml run --rm -p 5432:5432 --no-deps pg

docker-redis:
	@docker-compose -f ./docker-compose.yml run --rm -p 6379:6379 --no-deps -d redis

docker-memcache:
	@docker-compose -f ./docker-compose.yml run --rm -p 11211:11211 --no-deps -d memcache

create-user:
	PGPASSWORD=password psql -h localhost -U postgres -c "CREATE USER moonbase WITH SUPERUSER PASSWORD 'password';"

create-database:
	PGPASSWORD=password psql -h localhost -U postgres -c "CREATE DATABASE moonbase_development OWNER moonbase;"
	PGPASSWORD=password psql -h localhost -U postgres -c "CREATE DATABASE moonbase_test OWNER moonbase;"

bundler:
	@gem install bundler
	@bundler install

migrate:
	@rake db:migrate

seed:
	@rake db:seed
