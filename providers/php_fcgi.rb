#
# Cookbook Name:: application_php
# Provider:: php_fcgi
#
# Copyright 2012, Binary Marbles Trond Arve Nordheim
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Chef::Mixin::LanguageIncludeRecipe

action :before_compile do

  include_recipe 'php'

  new_resource.restart_command "/etc/init.d/#{new_resource.name} restart" if !new_resource.restart_command

end

action :before_deploy do
end

action :before_migrate do
end

action :before_symlink do
end

action :before_restart do

  new_resource = @new_resource
  
  runit_service new_resource.name do
    template_name 'php_fcgi'
    owner new_resource.owner if new_resource.owner 
    group new_resource.group if new_resource.group

    cookbook 'application_php'
    options(
      :app => new_resource
    )
    run_restart false
  end
  
end

action :after_restart do
end
