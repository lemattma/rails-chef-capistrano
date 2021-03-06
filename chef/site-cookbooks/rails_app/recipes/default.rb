#
# Cookbook Name:: rails_app
# Recipe:: default
#
# Copyright 2015, Martin Miranda
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'    # ensure the local APT package cache is up to date
include_recipe "build-essential"
include_recipe 'nginx'
include_recipe 'git'


# Create user 
# **************************************************************************************
user node[:user][:name] do
  password node[:user][:password]
  gid node[:user][:group]
  home "/home/#{node[:user][:name]}"
  supports manage_home: true
  shell "/bin/bash"
end


# Postgresql
# **************************************************************************************
include_recipe 'postgresql::server'
include_recipe 'postgresql::ruby'

postgresql_connection_info = {
  :host => "localhost",
  :port => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node[:user][:postgres_pass]
}

# Create app user
postgresql_database_user node[:user][:db_user] do
  connection postgresql_connection_info
  password node[:user][:db_pass]
  action :create
end

# Create app DB
postgresql_database node[:user][:db_name] do
  connection postgresql_connection_info
  action :create
end

# Grant permissions to DB
postgresql_database_user node[:user][:db_user] do
  connection    postgresql_connection_info
  database_name node[:user][:db_name]
  privileges    [:all]
  action        :grant
end


# PGP fix for RVM install
# **************************************************************************************
execute "Adding gpg key to #{node[:user][:name]}" do
  environment ({"HOME" => "/home/#{node[:user][:name]}"})
  command "`which gpg2 || which gpg` --keyserver hkp://keys.gnupg.net --recv-keys #{node['rvm']['gpg_key']};"
  user node[:user][:name]
  group node[:user][:group]
  not_if { node['rvm']['gpg_key'].empty? }
end


# RVM install
# **************************************************************************************
include_recipe "rvm::user"
