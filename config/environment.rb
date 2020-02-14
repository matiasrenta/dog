# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Sett = Admin::Settings # esto hace que Sett sea Admin::Settings, como un alias, asi noescribo tanto
