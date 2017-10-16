#
# Cookbook Name:: php56
# Recipe:: default
#
# Copyright 2014, KURT_GEIGER
#
# All rights reserved - Do Not Redistribute
#

app_name = 'php56'

packages = [ 
    "#{app_name}",
    "#{app_name}-cli",
    "#{app_name}-common",
    "#{app_name}-gd",
    "#{app_name}-mbstring",
    "#{app_name}-mcrypt",
    "#{app_name}-mysqlnd",
    "#{app_name}-pdo",
    "#{app_name}-process",
    "#{app_name}-soap",
    "#{app_name}-xml",
    "#{app_name}-xmlrpc",
    "#{app_name}-pecl-memcache",
    "#{app_name}-opcache"
]

packages.each do |pkg|
    yum_package pkg do
        action :install
    end
end
