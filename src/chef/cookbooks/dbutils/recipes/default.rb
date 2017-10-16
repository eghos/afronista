#
# Cookbook Name:: dbutils
# Recipe:: default
#
# Copyright 2016, KURT_GEIGER
#
# All rights reserved - Do Not Redistribute
#

include_recipe "mysql56::client"

root_dir = "/opt/dbutils"

directory "#{root_dir}" do
    action :create
end

for dir in ["bin", "etc", "libexec" ] do
    directory "#{root_dir}/#{dir}" do
        owner 'root'
        group 'root'
        mode  '0755'

        action :create
    end
end
