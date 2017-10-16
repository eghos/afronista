#
# Cookbook Name:: hostsfile
# Recipe:: aws_hostsfile
#
# Copyright 2015, Kurt Geiger Ltd
#
# All rights reserved - Do Not Redistribute
#

tmp_hostname = "#{node['environment']['name']}-#{node['project']['name']}-#{node['repository']['name']}-#{node['role']['name']}"

if "#{node['role']['multi']}" == "true"
    require "net/https"
    require "uri"

    uri = URI.parse("http://169.254.169.254/latest/meta-data/local-hostname")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    ip_local = response.body.strip.gsub(/\s+/, " ")
    new_hostname = "#{tmp_hostname}-#{ip_local}"
else
    new_hostname = tmp_hostname
end

ruby_block "edit sysconfig" do
    block do
        rc = Chef::Util::FileEdit.new("/etc/sysconfig/network")
        rc.search_file_replace_line(/^HOSTNAME=.*$/, "HOSTNAME=#{new_hostname}")
        rc.write_file
        #notifies :run, resources(:execute => "set hostname"), :immediately
    end
end

file '/etc/hostname' do
    content "#{new_hostname}"
end

execute "hostname #{new_hostname}" do
    not_if "hostname -eq '#{new_hostname}'"
end

hostsfile_entry '127.0.0.1' do
    hostname  "localhost localhost.localdomain #{new_hostname}.localdomain #{new_hostname}"
    unique    true
end
