Chef::Log.info("Running deploy/before_restart.rb...")

Chef::Log.info(new_resource.inspect)

#FileUtils.cp "#{new_resource.deploy_to}/shared/config/mws.rb", "#{release_path}/config/mws.rb"
