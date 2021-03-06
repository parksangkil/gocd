##########################################################################
# Copyright 2017 ThoughtWorks, Inc.
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
  module Admin
    module MergedEnvironments
      class AgentSummaryRepresenter < Shared::AgentSummaryRepresenter
        def initialize(options)
          @environment = options[:environment]
          @agent = options[:agent]

          super(@agent)
        end

        property :origin,
                 exec_context: :decorator,
                 decorator: lambda {|origin, *|
                   (origin.instance_of? FileConfigOrigin) ?
                     Shared::ConfigOrigin::ConfigXmlOriginRepresenter :
                     Shared::ConfigOrigin::ConfigRepoOriginRepresenter
                 }

        def origin
          @environment.isLocal ? FileConfigOrigin.new : @environment.getOriginForAgent(@agent.getUuid)
        end

        def uuid
          @agent.getUuid()
        end
      end
    end
  end
end