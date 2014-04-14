# coding: utf-8
#
# Cookbook Name:: vesta
# Recipe:: default
#
# Copyright 2014
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

installed_file = '/root/.vesta.installed'

unless File.exist?(installed_file)
  remote_file File.join(Chef::Config[:file_cache_path], 'vst-install.sh') do
    source 'http://vestacp.com/pub/vst-install.sh'
    mode '0700'
    owner 'root'
    group 'root'
  end

  execute 'Install Vesta' do
    cwd Chef::Config[:file_cache_path]
    command "bash vst-install.sh -e #{node['vesta']['email']} -f"
  end

  if node['vesta']['admin_pass_hash']
    password_hash = node['vesta']['admin_pass_hash']
  elsif node['vesta']['admin_password']
    chef_gem 'unix-crypt'

    require 'unix_crypt'
    password_hash = UnixCrypt::SHA512.build(node['vesta']['admin_password'])
  end

  if password_hash
    user 'admin' do
      action :modify
      password password_hash
    end
  end

  execute 'Touch installed file' do
    command "touch #{installed_file}"
  end
end
