#
# Cookbook Name:: dbutils
# Recipe:: dump
#
# Copyright 2016, KURT_GEIGER
#
# All rights reserved - Do Not Redistribute
#

root_dir = "/opt/dbutils"
conf_dir = "#{root_dir}/etc/dump"
transforms_dir = "#{conf_dir}/transforms"

directory "#{transforms_dir}" do
    action :create

    recursive true
end

cookbook_file "mydumper" do
    path "#{root_dir}/libexec/mydumper"

    owner 'root'
    group 'root'
    mode '0744'
end

template "#{root_dir}/bin/dump_db.sh" do
    source "dump_db.sh.erb"

    mode '0744'
    group 'root'
    owner 'root'

    variables({
        :s3_path => "#{node['bucket']['backups']['name']}/#{node['bucket']['backups']['path']}"
           })
end

cookbook_file "dump_all_dbs.sh" do
    path "#{root_dir}/bin/dump_all_dbs.sh"

    owner 'root'
    group 'root'
    mode '0744'
end

for conf_file in ["clear_login.conf", "reset_auto_increment.conf", "sanitized_tables.conf"] do
    cookbook_file "#{conf_file}" do
        path "#{transforms_dir}/#{conf_file}"

        owner 'root'
        group 'root'
        mode '0640'
    end
end

node['application']['domains'].each do |domain|
    template "#{conf_dir}/#{domain['short']}.conf" do
        source "dump.conf.erb"

        mode '0644'
        group 'root'
        owner 'root'

        variables({
            :project => "#{node['repository']['name']}",
            :source_db_host => "#{node['databases'][domain['database']['instance']]['endpoint']}",
            :source_db_name => "#{domain['database']['name']}",
            :source_db_user => "#{domain['database']['username']}",
            :source_db_password => "#{domain['database']['password']}",
            :source_db_domain => "#{domain['name']}",
            :sanitized_dump => "#{domain['dbutils']['sanitized']}"
        })
    end
end
