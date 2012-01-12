guard 'bundler' do
  watch('Gemfile')
end

guard 'spork', :wait => 30, :rspec_env => { 'RAILS_ENV' => 'test' }, :cucumber => false, :test_unit => false do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
end

group 'acceptance-tests' do
  guard 'rspec', version: 2, cli: '--drb', spec_paths: ['spec/acceptance'] do
    watch('spec/spec_helper.rb')  { "spec" }
    watch(%r{^spec/acceptance/.+_spec\.rb$})
    watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  end
end
group 'unit-tests' do
  guard 'rspec', :version => 2, :cli => '--drb', spec_paths: ['spec/models', 'spec/controllers'] do
    # Rails example
    watch(%r{^spec/(models|controllers|requests|helpers)/.+_spec\.rb$})
    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
    watch('spec/spec_helper.rb')                        { "spec" }
    watch('config/routes.rb')                           { "spec/routing" }
    watch('app/controllers/application_controller.rb')  { "spec/controllers" }
    # Capybara request specs
    watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
  end
end


guard 'jasmine', server: :thin do
  watch(%r{^app/assets/javascripts/(.+)\.(js\.coffee|js|coffee)$}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
  watch(%r{^spec/javascripts/(.+)_spec\.(js\.coffee|js|coffee)$})  { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
  watch(%r{^spec/javascripts/spec\.(js\.coffee|js|coffee)$})       { "spec/javascripts" }
end
