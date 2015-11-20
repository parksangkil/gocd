##########################################################################
# Copyright 2015 ThoughtWorks, Inc.
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
##########################################################################

module ApiV1
  module Config
    module Tasks
      class PluggableTaskRepresenter < ApiV1::Config::Tasks::BaseTaskRepresenter
        alias_method :pluggable_task, :represented

        property :plugin_configuration, decorator: PluginConfigurationRepresenter, class: PluginConfiguration
        collection :configuration, exec_context: :decorator, decorator: PluginConfigurationPropertyRepresenter, class: com.thoughtworks.go.domain.config.ConfigurationProperty
        #TODO: handle property_definition being nil

        def configuration
          pluggable_task.getConfiguration()
        end

        def configuration=(value)
          value.each { |config|
            pluggable_task.setConfiguration(config)
          }
        end
      end
    end
  end
end