RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf("public/dragonfly/test")
  end
end
