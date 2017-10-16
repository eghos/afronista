#
# Cookbook Name:: newrelic
# Recipe:: repository
#
# Copyright 2015, KURT_GEIGER_LTD
#
# All rights reserved - Do Not Redistribute
#

newrelic = node['newrelic']

remote_file "#{Chef::Config[:file_cache_path]}/newrelic-repo.rpm" do
    source newrelic['rpm']['location']

    action :create
end

rpm_package "newrelic" do
    source "#{Chef::Config[:file_cache_path]}/newrelic-repo.rpm"

    action :install
end
