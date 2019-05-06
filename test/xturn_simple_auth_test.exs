defmodule XturnSimpleAuthTest do
  use ExUnit.Case
  doctest XturnSimpleAuth

  test "greets the world" do
    assert Xirsys.XTurn.SimpleAuth.hello() == :world
  end
end
