defmodule HolidayApp.Holidays.HolidayLookup do
  use Ecto.Schema

  import Ecto.Changeset

  schema "holiday_lookups" do
    field(:holiday_name, :string)
    field(:holiday_date, :date)
    field(:days_until, :integer)
  end

  def changeset(lookup, attrs) do
    lookup
    |> cast(attrs, [:holiday_name, :holiday_date, :days_until])
    |> validate_required([:holiday_name, :holiday_date, :days_until])
  end
end
