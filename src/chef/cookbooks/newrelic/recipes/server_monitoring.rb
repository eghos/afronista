#
# Cookbook Name:: newrelic
# Recipe:: server_monitoring
#
# Copyright 2015, KURT_GEIGER_LTD
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'newrelic::repository'

newrelic = node['newrelic']

package "newrelic-sysmond" do
    action :install
end

# configure your New Relic license key
template "/etc/newrelic/nrsysmond.cfg" do
    source "nrsysmond.cfg.erb"
    owner 'newrelic'
    group 'newrelic'
    mode 0640
    variables(
        :license => newrelic['license']
    )
    
    notifies :restart, "service[newrelic-sysmond]", :delayed
end

service "newrelic-sysmond" do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
end
