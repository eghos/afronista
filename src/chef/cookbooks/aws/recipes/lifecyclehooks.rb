template "/usr/local/bin/lifecyclehooks.sh" do
    source "lifecyclehooks.sh.erb"

    mode '0755'
    group 'ec2-user'
    owner 'ec2-user'

    variables({
        :LIFECYCLE__HOOK => "#{node['lifecycle']['hook']}",
        :AUTOSCALING__GROUP => "#{node['web']['instance']['group']}"
        })
end
