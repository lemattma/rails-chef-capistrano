# User
# **************************************************************************************
default[:user][:name]  		    	= "deployer"
default[:user][:group]  		    = "admin"
default[:user][:password]     		= "$1$7H9CAJGM$KwTwhmSwTZqo4RtI0n.Rr."
default[:user][:ls_color]     		= true

# Secret data examples. 
# TODO: Use data bags
# **************************************************************************************
default[:user][:db_user]  		    = "app_user"
default[:user][:db_name]  		    = "app_production"
default[:user][:db_pass]  		    = "dev123"
default[:user][:postgres_pass]  	= "dev123"


# RVM config
# **************************************************************************************
node.set[:rvm][:user_rubies] 			= ['2.2.0']
node.set[:rvm][:user_install_rubies] 	= true
node.set[:rvm][:user_default_ruby] 		= '2.2.0'
node.set[:rvm][:user_global_gems] 		= [{ name: 'bundler' } ]
# Install rvm
node.set[:rvm][:installs] = {
  node[:user][:name] => {}
}
# Install rubies
node.set[:rvm][:user_installs] = [
  {user: node[:user][:name]}
]


# Postgresql config
# **************************************************************************************
node.set[:postgresql][:pg_hba] = [
  {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'ident'},
  {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'md5'},
  {:type => 'host',  :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
  {:type => 'host',  :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'}
]
# node.set[:postgresql][:config][:listen_addresses] = '*'
node.set[:postgresql][:password][:postgres] = "md5" + Digest::MD5.hexdigest("#{node[:user][:postgres_pass]}postgres")