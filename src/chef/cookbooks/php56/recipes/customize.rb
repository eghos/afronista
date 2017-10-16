#
# Cookbook Name:: php56
# Recipe:: custom
#
# Copyright 2017, KURT_GEIGER
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "kg_custom.ini" do
    source "kg_custom.ini"
    path "/etc/php.d/custom.ini"

    owner 'root'
    group 'root'
    mode  '0644'

    # Only restart http if the template file has changed
    notifies :reload, 'service[apache]'
end
