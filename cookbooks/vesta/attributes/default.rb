# coding: utf-8
#
# Cookbook Name:: rax-wordpress
# Attribute:: default
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

default['vesta']['email'] = 'root@localhost'
default['vesta']['admin_pass_hash'] = nil
# Don't pass in a plain text password, please use the hash if possible. If you
# do, we'll convert it to a hash for use with the chef user resource.
default['vesta']['admin_password'] = nil
