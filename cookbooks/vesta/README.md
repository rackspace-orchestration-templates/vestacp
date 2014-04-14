Description
-----------
Cookbook to install [Vesta Control Panel](http://vestacp.com/).  Pass in an
admin password to have it set the admin password to something you know.  If
you don't pass in a password hash, you'll need to reset the admin user
password before logging into Vesta.

Requirements
------------
Chef 11+

Platform
--------
* Ubuntu
* Debian
* CentOS

Cookbooks
---------
This cookbook depends on the following cookbooks:
* `firewall`
* `iptables_ng`

Recipes
-------
* `default`: Installs the Vesta control panel
* `firewall`: Opens the Vesta managment port (8083) in the firewall

Attributes
----------
* `node['vesta']['email']`: Email address of the Vesta administrator
* `node['vesta']['admin_pass_hash']`: Password hash for the `admin` user
* `node['vesta']['admin_password']`: Plain text password to use for the `admin`
user. Use `node['vesta']['admin_pass_hash']` instead.

Usage
-----
On nodes, use the default recipe:
```javascript
{ "run_list": ["recipe[vesta]"] }
```

License and Author
------------------
- Author:: Brint O'Hearn (<brint.ohearn@rackspace.com>)

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
