module DlDashboardTopic
  class DashboardTopicController < ApplicationController
    requires_plugin 'dl-dashboard-topic'
    
    skip_before_action :preload_json, :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token
    before_action :add_allow_headers, only: [:index]

    def add_allow_headers
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'   
      response.headers['Access-Control-Allow-Credentials'] = 'true'
      response.headers['Access-Control-Allow-Headers'] = 'accept, content-type'
    end

    def index
      Jobs.enqueue(:log_dashboard_site, {ip: request.remote_ip, domain: "#{request.protocol}#{request.host_with_port}"})
      text = Topic.find(SiteSetting.dashboard_topic_id).first_post.cooked
      render json: {cooked: text}
    end

  end
end