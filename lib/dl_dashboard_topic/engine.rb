module DlDashboardTopic
  class Engine < ::Rails::Engine
    isolate_namespace DlDashboardTopic

    config.after_initialize do
      require_dependency "jobs/base"
      module ::Jobs

        class LogDashboardSite < Jobs::Base
          def execute(args)
            if (args[:ip] && args[:domain])
              dashboard_sites = PluginStore.get("dl_dashboard_topic", "dashboard_sites") || []
              time = Time.now

              if dashboard_sites.empty?
                site = []
              else
                site = dashboard_sites.select{|site| site[:ip] == args[:ip] && site[:domain] == args[:domain]}
              end

              if site.empty?
                id = dashboard_sites.count + 1

                new_site = {
                  id: id,
                  ip: args[:ip],
                  domain: args[:domain],
                  first_load: time,
                  latest_load: time,
                  load_count: 1
                }

                dashboard_sites.push(new_site)
              else
                new_load_count = site[0][:load_count] + 1
                site[0][:latest_load] = time
                site[0][:load_count] = new_load_count
              end

              PluginStore.set("dl_dashboard_topic", "dashboard_sites", dashboard_sites)
              
            end
          end
        end

      end
    end

  end
end