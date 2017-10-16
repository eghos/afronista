#
# Cookbook Name:: sshusers
# Recipe:: sudoers
#
# Copyright 2016, KURT_GEIGER
#
# All rights reserved - Do Not Redistribute
#
# SB: There is a chef supermarket cookbook, sudo, that should do what we want.
#     However it likes to replace the /etc/sudoers file with one of its own creation, and it proved
#     difficult to configure this to be like the AWS linux one, or at the very least to allow passwordless sudo
#     and use the /etc/sudoers.d/ directory, despite the fact it creates files in that directory by default!

include_recipe 'aws'
include_recipe 'user'

node.default['sshusers']['users'].each do |user|
    if user[:sudo]
        # from the sudoers manual: "sudo will read each file in /etc/sudoers.d, skipping file names that end in ‘~’ or contain a ‘.’ character"
        username_no_dots = user[:name].delete "."
        template "/etc/sudoers.d/#{username_no_dots}" do
            source 'sudoers.d-file.erb'
            backup false
            owner 'root'
            group 'root'
            mode '0440'
            variables ({
                :username => user[:name]
            })
        end
    end
end
