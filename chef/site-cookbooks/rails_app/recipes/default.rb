#
# Cookbook Name:: rails_app
# Recipe:: default
#
# Copyright 2015, Martin Miranda
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'    # ensure the local APT package cache is up to date
include_recipe 'nginx'
include_recipe 'git'
# include_recipe 'postgresql'


# Create user 
# **************************************************************************************
user node[:user][:name] do
  password node[:user][:password]
  gid node[:user][:group]
  home "/home/#{node[:user][:name]}"
  supports manage_home: true
  shell "/bin/bash"
end


# PGP fix for RVM install
# **************************************************************************************
gnupg_dir       = "/home/#{node[:user][:name]}/.gnupg"
gnupg_dir_user  = "chown -R #{node[:user][:name]}:#{node[:user][:group]} #{gnupg_dir};"
gnupg_dir_root  = "if [ -d #{gnupg_dir} ]; then chown -R root:root #{gnupg_dir}; fi;"
gnupg_cmd       = "`which gpg2 || which gpg` --keyserver hkp://keys.gnupg.net --recv-keys #{node['rvm']['gpg_key']};"

execute "Adding gpg key to #{node[:user][:name]}" do
  environment ({"HOME" => "/home/#{node[:user][:name]}"})
  command "#{gnupg_dir_root} #{gnupg_cmd} #{gnupg_dir_user}"
  not_if { node['rvm']['gpg_key'].empty? }
  returns 0
end


# RVM install
# **************************************************************************************
include_recipe "rvm::user"
