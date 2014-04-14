# coding: utf-8
#
# Cookbook Name:: vesta
# Recipe:: firewall
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

listen_port = 8083

case node['platform']
when 'ubuntu'
  firewall_rule "Firewall rule, tcp/#{listen_port}" do
    port      listen_port.to_i
    protocol  :tcp
    direction :in
    action    :allow
  end
when 'rhel', 'centos', 'debian'
  iptables_ng_rule 'Firewall rule, tcp/#{listen_port}' do
    name       'Vesta'
    chain      'INPUT'
    table      'filter'
    ip_version [4, 6]
    rule       "-p tcp --dport #{listen_port} -j ACCEPT"
    action     :create_if_missing
  end
end
