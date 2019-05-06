### ----------------------------------------------------------------------
###
### Copyright (c) 2013 - 2018 Lee Sylvester and Xirsys LLC <experts@xirsys.com>
###
### All rights reserved.
###
### XTurn is licensed by Xirsys under the Apache
### License, Version 2.0. (the "License");
###
### you may not use this file except in compliance with the License.
### You may obtain a copy of the License at
###
###      http://www.apache.org/licenses/LICENSE-2.0
###
### Unless required by applicable law or agreed to in writing, software
### distributed under the License is distributed on an "AS IS" BASIS,
### WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
### See the License for the specific language governing permissions and
### limitations under the License.
###
### See LICENSE for the full license text.
###
### ----------------------------------------------------------------------

defmodule Xirsys.XTurn.SimpleAuth.Client do
  @moduledoc """
  """
  use GenServer
  require Logger
  @vsn "0"

  @auth_lifetime 300_000

  #########################################################################################################################
  # Interface functions
  #########################################################################################################################

  def start_link([]),
    do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def create_user(ns),
    do: GenServer.call(__MODULE__, {:create_user, ns, ""})

  def create_user(ns, peer_id),
    do: GenServer.call(__MODULE__, {:create_user, ns, peer_id})

  def add_user(username, pass, ns, peer_id),
    do: GenServer.call(__MODULE__, {:add_user, username, pass, ns, peer_id})

  def get_pass(username),
    do: GenServer.call(__MODULE__, {:get_pass, username})

  def get_details(username),
    do: GenServer.call(__MODULE__, {:get_details, username})

  def get_count(),
    do: GenServer.call(__MODULE__, :get_count)

  def get_count(username, password),
    do: GenServer.call(__MODULE__, {:get_count, username, password})

  #########################################################################################################################
  # OTP functions
  #########################################################################################################################

  def init([]) do
    Logger.info("Initialising auth store")
    Xirsys.XTurn.Cache.Store.init(@auth_lifetime)
  end

  def handle_call({:create_user, ns, peer_id}, _from, state) do
    username = Xirsys.XTurn.SimpleAuth.UUID.utc_random()
    password = Xirsys.XTurn.SimpleAuth.UUID.utc_random()
    Xirsys.XTurn.Cache.Store.append_item_to_store(state, {username, {password, ns, peer_id}})
    {:reply, {:ok, username, password}, state}
  end

  def handle_call({:add_user, user, pass, ns, peer_id}, _from, state) do
    Xirsys.XTurn.Cache.Store.append_item_to_store(state, {user, {pass, ns, peer_id}})
    {:reply, {:ok, user, pass}, state}
  end

  def handle_call({:get_pass, "user"}, _from, state), do: {:reply, {:ok, "pass"}, state}

  def handle_call({:get_pass, username}, _from, state) do
    case Xirsys.XTurn.Cache.Store.fetch(state, username) do
      {:ok, {pass, _, _}} ->
        {:reply, {:ok, pass}, state}

      _ ->
        {:reply, :error, state}
    end
  end

  def handle_call({:get_details, "user"}, _from, state),
    do: {:reply, {:ok, "pass", nil, nil}, state}

  def handle_call({:get_details, username}, _from, state) do
    case Xirsys.XTurn.Cache.Store.fetch(state, username) do
      {:ok, {pass, ns, peer_id}} ->
        {:reply, {:ok, pass, ns, peer_id}, state}

      _ ->
        {:reply, :error, state}
    end
  end

  def handle_call(:get_count, _from, state) do
    {:reply, Xirsys.XTurn.Cache.Store.get_item_count(state), state}
  end
end
