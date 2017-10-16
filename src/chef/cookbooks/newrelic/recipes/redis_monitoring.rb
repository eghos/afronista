#
# Cookbook Name:: newrelic
# Recipe:: redis_monitoring
#
# Copyright 2015, KURT_GEIGER_LTD
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python::pip"

newrelic = node['newrelic']
redis = node['redis']

yum_package "python26-pip" do
    action :install
end

python_pip "newrelic-plugin-agent" do
    version "1.3.0"

    action :install 
end

# configure your New Relic license key
template "/etc/newrelic/newrelic-plugin-agent.cfg" do
    source "newrelic-plugin-agent.cfg.erb"
    owner 'newrelic'
    group 'newrelic'
    mode 0640

    variables(
        :license => newrelic['license'],
        :servers => redis['servers']
    )
    
    notifies :restart, "service[newrelic-sysmond]", :delayed
end

bash 'startup' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    newrelic-plugin-agent -c /etc/newrelic/newrelic-plugin-agent.cfg
    EOH
end