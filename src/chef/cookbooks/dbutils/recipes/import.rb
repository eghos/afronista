#
# Cookbook Name:: dbutils
# Recipe:: import
#
# Copyright 2016, KURT_GEIGER
#
# All rights reserved - Do Not Redistribute
#

root_dir = "/opt/dbutils"
conf_dir = "#{root_dir}/etc/import"

directory "#{conf_dir}" do
    action :create
end

cookbook_file "myloader" do
    path "#{root_dir}/libexec/myloader"

    owner 'root'
    group 'root'
    mode '0744'
end

template "#{root_dir}/bin/import_db.sh" do
    source "import_db.sh.erb"

    mode '0744'
    group 'root'
    owner 'root'

    variables({
        :s3_path => "#{node['bucket']['backups']['name']}/#{node['bucket']['backups']['path']}"
           })
end

cookbook_file "import_pristine_db.sh" do
    path "#{root_dir}/bin/import_pristine_db.sh"

    owner 'root'
    group 'root'
    mode '0744'
end

cookbook_file "import_all_dbs.sh" do
    path "#{root_dir}/bin/import_all_dbs.sh"

    owner 'root'
    group 'root'
    mode '0744'
end

cron "import fresh sanitized dbs" do
    minute "0"
    hour "2"
    command "#{root_dir}/bin/import_all_dbs.sh >> /var/log/import_db.log"
    action :create
end

node['application']['domains'].each do |domain|

    if not node['role']['domain'].nil? and node['role']['domain'] != domain['name']
        next
    end

    template "#{conf_dir}/#{domain['database']['name']}.conf" do
        source "import.conf.erb"

        mode '0644'
        group 'root'
        owner 'root'

        variables({
            :source_db_domain => "#{domain['dbutils']['source']}",
            :target_db_host => "#{node['databases'][domain['database']['instance']]['endpoint']}",
            :target_db_name => "#{domain['database']['name']}",
            :target_db_user => "#{domain['database']['username']}",
            :target_db_password => "#{domain['database']['password']}",
            :target_db_domain => "#{domain['name']}",
            :test_db_import => "#{domain['dbutils']['dbtest']}",
            :backup_type => "#{domain['dbutils']['type']}"
        })
    end
    if "#{domain['dbutils']['post']}" == "true"
        users = if node.default['admins'].empty? and node.default['user_passwords'].empty? then "false" else "true" end
        payments = if "#{domain['dbutils']['payments']}" == "true" then "true" else "false" end
        feeds = if "#{domain['dbutils']['feeds']}" == "true" then "true" else "false" end
        template "#{conf_dir}/#{domain['database']['name']}.post" do
            source 'post.erb'

            mode '0644'
            group 'root'
            owner 'root'

            variables({
                :users => users,
                :user_passwords => node.default['user_passwords'],
                :admins => node.default['admins'],
                :payments => payments,
                :feeds => feeds
            })
        end
    end
end
