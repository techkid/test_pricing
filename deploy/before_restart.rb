Chef::Log.info("Running deploy/before_restart.rb...")

template "#{release_path}/config/mws.rb" do
  source "#{release_path}/deploy/templates/mws.rb.erb"
  mode "0660"
  owner deploy[:user]
  group deploy[:group]
  variables(:data => (node[:deploy][new_resource.application.to_sym][:mws] || {}), :environment => new_resource.environment["RAILS_ENV"])
end.run_action(:create)
