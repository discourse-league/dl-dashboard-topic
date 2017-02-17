module DlDashboardTopic
  class DashboardTopicController < ApplicationController
    requires_plugin 'dl-dashboard-topic'
    
    skip_before_filter :preload_json, :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token

    def index
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
      response.headers['Access-Control-Allow-Headers'] = '*'
      text = Topic.find(SiteSetting.dashboard_topic_id).first_post.cooked
      render json: {cooked: text}
    end

  end
end