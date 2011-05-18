# Be sure to restart your server when you modify this file.

Roomies::Application.config.session_store :cookie_store, :key => '_roomies_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Roomies::Application.config.session_store :active_record_store
# require 'action_dispatch/middleware/session/dalli_store'
# Rails.application.config.session_store  :dalli_store, 
#                                         :memcache_server => [MEMCACHE_SERVERS], 
#                                         :namespace => 'sessions', 
#                                         :key => '_roomies_session',
#                                         :expire_after => 30.minutes

