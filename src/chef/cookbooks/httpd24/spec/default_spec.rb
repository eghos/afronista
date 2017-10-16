
require 'chefspec'

  describe 'httpd24::default' do
    let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
    
    it 'installs a httpd24 package' do
      expect(chef_run).to install_yum_package('httpd24')
    end
    
    it 'creates a directory /etc/httpd/conf.d/sites' do
      expect(chef_run).to create_directory('/etc/httpd/conf.d/sites').with(
        owner: 'apache',
        group: 'apache',
        mode: '0664', 
        recursive: true,
        )
    end
    
    it 'creates a template httpd_sites_conf' do
      expect(chef_run). to create_template_if_missing('/etc/httpd/conf.d/sites.conf').with(
        source: 'sites.conf.erb',
        mode: '0664',
        owner: 'apache',
        group: 'apache',
        backup: false,
        )
    end
    
    it 'enables and starte the httpd servives' do
      expect(chef_run). to enable_service('httpd')
      expect(chef_run).to start_service('httpd')
    end
end