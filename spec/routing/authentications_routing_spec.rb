require 'spec_helper'

describe 'routing to authentications' do
  it 'routes /auth/:provider/callback to authtications#create' do
    { get:  '/auth/twitter/callback' }.should route_to(
      controller: 'authentications',
      action: 'create',
      provider: 'twitter'
    )
  end

  it 'routes /auth/failure to authentications#failure' do
    { get: '/auth/failure' }.should route_to(
      controller: 'authentications',
      action: 'failure'
    )
  end
end
