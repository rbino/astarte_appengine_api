defmodule Astarte.AppEngine.API.Config do
  @moduledoc """
  This module contains functions to access the configuration
  """

  @doc """
  Returns the MQTT options
  """
  def mqtt_options do
    Application.get_env(:astarte_appengine_api, :mqtt_options, [])
  end

  @doc """
  Returns true if the authentication is disabled
  """
  def authentication_disabled? do
    Application.get_env(:astarte_appengine_api, :disable_authentication, false)
  end
end
