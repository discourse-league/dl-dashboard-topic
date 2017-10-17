module DlDashboardTopic
  class DashboardTopicController < ApplicationController
    requires_plugin 'dl-dashboard-topic'
    
    skip_before_action :preload_json, :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token

    def index
      Jobs.enqueue(:log_dashboard_site, {ip: request.remote_ip, domain: "#{request.protocol}#{request.host_with_port}"})
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
      response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-CSRF-Token'
      response.headers['X-Frame-Options'] = "ALLOWALL"
      text = Topic.find(SiteSetting.dashboard_topic_id).first_post.cooked
      render json: {cooked: text}
    end

  end
end