# User
# **************************************************************************************
default[:user][:name]  		    	= "deployer"
default[:user][:group]  		    = "admin"
default[:user][:password]     		= "$1$ZcV0xymc$oVuT4051uSKVj8T/w9CYC/"
default[:user][:ls_color]     		= true

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
node.set[:postgresql][:assign_postgres_password] = false
node.set[:postgresql][:password][:postgres] = "md54ad0c5914ca3273e5159c4218f033f20"
