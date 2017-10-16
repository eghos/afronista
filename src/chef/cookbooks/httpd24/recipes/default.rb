#
# Cookbook Name:: httpd24
# Recipe:: default
#
# Copyright 2014, KURT_GEIGER
#
# All rights reserved - Do Not Redistribute
#

yum_package "httpd24" do
    action :install
end

directory "/etc/httpd/conf.d/sites" do
    owner 'apache'
    group 'apache'
    mode '0664'
    
    recursive true
    
    action :create
end

template "httpd_sites_conf" do
    source "sites.conf.erb"

    mode '0664'
    owner 'apache'
    group 'apache'

    path "/etc/httpd/conf.d/sites.conf"
    backup false

    action :create_if_missing
end

cookbook_file "prefork.conf" do
    path "/etc/httpd/conf.d/prefork.conf"

    owner 'apache'
    group 'apache'
    mode '0644'

    notifies :reload, 'service[apache]'
end

service "apache" do
    service_name "httpd"

    action [ :enable, :start ]
end
