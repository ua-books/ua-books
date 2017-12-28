RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf("public/system/dragonfly/test")
  end
end
