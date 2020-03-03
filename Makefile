init:
	bundle config set path vendor/bundle
	bundle

init-prod:
	bundle config set path vendor/bundle
	bundle install --without development

drop:
	bundle exec rake db:drop

create:
	bundle exec rake db:create

migrate:
	bundle exec rake db:migrate

reset:
	bundle exec rake db:reset
