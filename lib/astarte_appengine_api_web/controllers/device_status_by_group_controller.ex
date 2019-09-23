#
# This file is part of Astarte.
#
# Copyright 2019 Ispirata Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
defmodule Astarte.AppEngine.APIWeb.DeviceStatusByGroupController do
  use Astarte.AppEngine.APIWeb, :controller

  alias Astarte.AppEngine.API.Device.DevicesList
  alias Astarte.AppEngine.API.Groups

  plug Astarte.AppEngine.APIWeb.Plug.AuthorizePath

  action_fallback Astarte.AppEngine.APIWeb.FallbackController

  def index(
        conn,
        %{"realm_name" => realm_name, "group_name" => group_name, "details" => "true"} = params
      ) do
    decoded_group_name = URI.decode(group_name)

    with {:ok, %DevicesList{} = devices_list} <-
           Groups.list_detailed_devices(realm_name, decoded_group_name, params) do
      render(conn, "detailed_index.json", devices_list: devices_list, request: params)
    end
  end

  def index(conn, %{"realm_name" => realm_name, "group_name" => group_name} = params) do
    decoded_group_name = URI.decode(group_name)

    with {:ok, %DevicesList{} = devices_list} <-
           Groups.list_devices(realm_name, decoded_group_name, params) do
      render(conn, "index.json", devices_list: devices_list, request: params)
    end
  end
end
