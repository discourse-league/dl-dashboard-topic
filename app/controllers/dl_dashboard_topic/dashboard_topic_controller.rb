module DlDashboardTopic
  class DashboardTopicController < ApplicationController
    requires_plugin 'dl-dashboard-topic'
    
    skip_before_filter :check_xhr, only: [:index]

    def index
      text = Topic.find(SiteSetting.dashboard_topic_id).first_post.cooked
      render json: {cooked: text}
    end

  end
end