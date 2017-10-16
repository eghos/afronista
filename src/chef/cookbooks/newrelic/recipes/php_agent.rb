#
# Cookbook Name:: newrelic
# Recipe:: php_agent
#
# Copyright 2015, KURT_GEIGER_LTD
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'newrelic::repository'
include_recipe 'httpd24'

newrelic = node['newrelic']

# install/update latest php agent
package 'newrelic-php5' do
    action :install
    notifies :run, 'execute[newrelic-install]', :immediately
end

# run newrelic-install
execute 'newrelic-install' do
    command 'newrelic-install install'
    environment(
        'NR_INSTALL_SILENT' => '1'
    )
    action :nothing

    notifies :restart, "service[apache]", :delayed
end

template "/etc/php.d/newrelic.ini" do
    source "newrelic.ini.erb"
    owner 'newrelic'
    group 'newrelic'
    mode 0644
    variables(
        :enabled => newrelic['application_monitoring']['enabled'],
        :license => newrelic['license'],
        :logfile => newrelic['application_monitoring']['logfile'],
        :loglevel => newrelic['application_monitoring']['loglevel'],
        :app_name => newrelic['application_monitoring']['app_name'],
        :daemon_logfile => newrelic['application_monitoring']['daemon']['logfile'],
        :daemon_loglevel => newrelic['application_monitoring']['daemon']['loglevel'],
        :daemon_port => newrelic['application_monitoring']['daemon']['port'],
        :daemon_max_threads => newrelic['application_monitoring']['daemon']['max_threads'],
        :daemon_ssl => newrelic['application_monitoring']['daemon']['ssl'],
        :daemon_ssl_ca_path => newrelic['application_monitoring']['daemon']['ssl_ca_path'],
        :daemon_ssl_ca_bundle => newrelic['application_monitoring']['daemon']['ssl_ca_bundle'],
        :daemon_proxy => newrelic['application_monitoring']['daemon']['proxy'],
        :daemon_pidfile => newrelic['application_monitoring']['daemon']['pidfile'],
        :daemon_location => newrelic['application_monitoring']['daemon']['location'],
        :daemon_collector_host => newrelic['application_monitoring']['daemon']['collector_host'],
        :daemon_dont_launch => newrelic['application_monitoring']['daemon']['dont_launch'],
        :capture_params => newrelic['application_monitoring']['capture_params'],
        :ignored_params => newrelic['application_monitoring']['ignored_params'],
        :error_collector_enable => newrelic['application_monitoring']['error_collector']['enable'],
        :error_collector_record_database_errors => newrelic['application_monitoring']['error_collector']['record_database_errors'],
        :error_collector_prioritize_api_errors => newrelic['application_monitoring']['error_collector']['prioritize_api_errors'],
        :browser_monitoring_auto_instrument => newrelic['application_monitoring']['browser_monitoring']['auto_instrument'],
        :transaction_tracer_enable => newrelic['application_monitoring']['transaction_tracer']['enable'],
        :transaction_tracer_threshold => newrelic['application_monitoring']['transaction_tracer']['threshold'],
        :transaction_tracer_detail => newrelic['application_monitoring']['transaction_tracer']['detail'],
        :transaction_tracer_slow_sql => newrelic['application_monitoring']['transaction_tracer']['slow_sql'],
        :transaction_tracer_stack_trace_threshold => newrelic['application_monitoring']['transaction_tracer']['stack_trace_threshold'],
        :transaction_tracer_explain_threshold => newrelic['application_monitoring']['transaction_tracer']['explain_threshold'],
        :transaction_tracer_record_sql => newrelic['application_monitoring']['transaction_tracer']['record_sql'],
        :transaction_tracer_custom => newrelic['application_monitoring']['transaction_tracer']['custom'],
        :framework => newrelic['application_monitoring']['framework'],
        :webtransaction_name_remove_trailing_path => newrelic['application_monitoring']['webtransaction']['name']['remove_trailing_path'],
        :webtransaction_name_functions => newrelic['application_monitoring']['webtransaction']['name']['functions'],
        :webtransaction_name_files => newrelic['application_monitoring']['webtransaction']['name']['files'],
        :cross_application_tracer_enable => newrelic['application_monitoring']['cross_application_tracer']['enable']
    )
    action :create

    notifies :restart, "service[apache]", :delayed
end