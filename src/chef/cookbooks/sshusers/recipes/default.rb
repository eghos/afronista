#
# Cookbook Name:: sshusers
# Recipe:: default
#
# Copyright 2016, KURT_GEIGER
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'aws'
include_recipe 'user'

node['sshusers']['users'].each do |user|
    user_account user[:name] do
        ssh_keygen false
        if user[:lock]
            action [:create, :lock]
            ssh_keys [""]
        else
            action [:create, :unlock]
            ssh_keys user[:ssh_public_keys]
        end
    end
end
