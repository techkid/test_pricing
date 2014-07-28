Chef::Log.info("Running deploy/before_restart.rb...")

template "#{release_path}/config/mws.rb" do
  source "#{release_path}/deploy/templates/mws.rb.erb"
  local true
  mode "0660"
  owner new_resource.user
  group new_resource.group
  variables(:data => (new_resource.params[:deploy_data]["mws"] || {}), :environment => new_resource.environment["RAILS_ENV"])
end.run_action(:create)
