module DlDashboardTopic
  class DashboardTopicController < ApplicationController
    requires_plugin 'dl-dashboard-topic'
    
    skip_before_filter :check_xhr, only: [:index]

    def index
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
      response.headers['Access-Control-Request-Method'] = '*'
      text = Topic.find(SiteSetting.dashboard_topic_id).first_post.cooked
      render json: {cooked: text}
    end

  end
end