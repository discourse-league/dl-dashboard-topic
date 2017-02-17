# name: dl-dashboard-topic
# about: Adds the ability to retrieve topic cooked for use in a plugin dashboard.
# version: 0.1
# author: Joe Buhlig joebuhlig.com
# url: https://www.github.com/discourseleague/dl-dashboard-topic

enabled_site_setting :dashboard_topic_enabled

Discourse::Application.routes.append do
  get '/dashboard-topic' => 'dl_dashboard_topic/dashboard_topic#index'
end

load File.expand_path('../lib/dl_dashboard_topic/engine.rb', __FILE__)