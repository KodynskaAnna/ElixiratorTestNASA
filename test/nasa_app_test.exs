defmodule NasaAppTest do
  use ExUnit.Case
  doctest NasaApp

  test "greets the world" do
    assert NasaApp.hello() == :world
  end
end
