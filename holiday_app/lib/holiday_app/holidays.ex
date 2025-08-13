defmodule HolidayApp.Holidays do

  @moduledoc false
  import Ecto.Query, warn: false
  alias HolidayApp.Repo
  alias HolidayApp.Holidays.HolidayLookup


  def list_lookups do
    from(h in HolidayLookup, order_by: [desc: h.inserted_at]) |> Repo.all()
  end

  def create_lookup(attrs) do
    %HolidayLookup{}
    |> HolidayLookup.changeset(attrs)
    |> Repo.insert()
  end
end
