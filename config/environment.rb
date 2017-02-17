require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'

require 'dry-auto_inject'
require 'sidekiq'
require 'sidekiq/web'


require_relative './initializers/dry_auto-inject'
require_relative './initializers/dry-monads'
require_relative '../lib/malproksimo'
require_relative '../apps/api/application'
require_relative '../apps/web/application'
require_relative './sidekiq'

Hanami.configure do
  mount Sidekiq::Web,     at: '/sidekiq'
  mount Api::Application, at: '/api'
  mount Web::Application, at: '/'


  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/malproksimo_development.sqlite3'
    #    adapter :sql, 'postgres://localhost/malproksimo_development'
    #    adapter :sql, 'mysql://localhost/malproksimo_development'
    #
    adapter :sql, ENV['DATABASE_URL']

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/malproksimo/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery do
      development :test
      test        :test
      # production :smtp, address: ENV['SMTP_PORT'], port: 1025
    end
  end
end
