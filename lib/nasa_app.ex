defmodule NasaApp do
   @moduledoc """
   The goal of this application is to calculate fuel to launch from one planet of the Solar system,
   and to land on another planet of the Solar system, depending on the flight route.
  """

  @first_launch_constant 0.042
  @second_launch_constant 33
  @first_land_constant 0.033
  @second_land_constant 42

  @doc """
   Call method, which takes the mass of the ship and the flight route as 2 arguments.
   Since we don’t have a refuel station in space -
   and we need to carry fuel for all steps from the very beginning the calculation is started reversibly.
   The required fuel for launch and landing is calculated recursively.
  """
  def fuel_calculation(ship_mass, route) do
    reverse_route = Enum.reverse(route)

    fuel_mass =
      Enum.reduce(reverse_route, ship_mass, fn
        {:launch, gravity}, acc ->
          launch_fuel = launch(acc, gravity, 0) + acc

        {:land, gravity}, acc ->
          land_fuel = land(acc, gravity, 0) + acc
      end)

    fuel_mass - ship_mass
  end

  @doc """
    Recursive function to calculate the fuel needed to launch a ship
  """
  def launch(mass, gravity, accumulator) when mass > 1 do
    fuel = floor(mass * gravity * @first_launch_constant - @second_launch_constant)
    launch(fuel, gravity, fuel + accumulator)
  end

  def launch(mass, gravity, accumulator) when mass <= 1 do
    accumulator + abs(mass)
  end

  @doc """
    Recursive function to calculate the fuel needed to land a ship
  """
  def land(mass, gravity, accumulator) when mass > 1 do
    fuel = floor(mass * gravity * @first_land_constant - @second_land_constant)
    land(fuel, gravity, fuel + accumulator)
  end

  def land(mass, gravity, accumulator) when mass <= 1 do
    accumulator + abs(mass)
  end
end
