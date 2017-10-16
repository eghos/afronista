require 'chefspec'

describe 'php56::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'installs the php56 required package list' do 
    app_name = 'php56'
    packages = %w{
        {app_name}",
    "#{app_name}-cli",
    "#{app_name}-common",
    "#{app_name}-gd",
    "#{app_name}-mbstring",
    "#{app_name}-mcrypt",
    "#{app_name}-mysql",
    "#{app_name}-pdo",
    "#{app_name}-process",
    "#{app_name}-soap",
    "#{app_name}-xml",
    "#{app_name}-xmlrpc",
    "#{app_name}-pecl-memcache",
    }

    packages.each do |pkg|
        expect(chef_run).to install_yum_package("#{app_name}")
    end
    end
end
