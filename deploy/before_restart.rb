Chef::Log.info("Running deploy/before_restart.rb...")

link "#{release_path}/config/mws.yml" do
  to "#{new_resource.deploy_to}/shared/config/database.yml"
end
