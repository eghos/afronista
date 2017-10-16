#
# Cookbook Name:: mysql56
# Recipe:: client
#
# Copyright 2016, KURT_GEIGER
#
# All rights reserved - Do Not Redistribute
#

yum_package 'mysql56' do
    action :install
end

yum_package 'mysql56-libs' do
    action :install
end
