 require 'chefspec'
 
   describe 'git::default' do
     let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
     
     it 'installs the git package'do 
       expect(chef_run).to install_yum_package('git')
     end
 end