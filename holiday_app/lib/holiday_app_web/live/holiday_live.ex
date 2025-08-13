defmodule HolidayApp.HolidayLive do
  use HolidayAppWeb, :live_view
  alias HolidayApp.Holidays
  require Logger


  @api_url "https://date.nager.at/api/v3/publicholidays/2025/US"

  @impl true

  def mount(_params, _session, socket) do
    holidays =
      case fetch_holidays() do
        {:ok, hs} -> hs
        {:error, _} -> []
      end

      {:ok,
        socket
        |> assign(:holidays, holidays)
        |> assign(:selected, nil)
        |> assign(:lookups, Holidays.list_lookups())
        |> assign(:error, nil)}
  end

  @impl true
  def handle_event("select", %{"holiday" => name}, socket) do
    {:noreply, assign(socket, :selected, name)}
  end
  @impl true
  def handle_event("calculate", %{"holiday" => name}, socket) do
    with {:ok, holidays} <- fetch_holidays(),
      {:ok, %{name: hname, date: hdate}} <- find_holiday_by_name(holidays, name) do
        today = Date.utc_today()
        {:ok, holiday_date} = Date.from_iso8601(hdate)
        days_until = Date.diff(holiday_date, today)


        {:ok, _record} = Holidays.create_lookup(%{
          holiday_name: hname,
          holiday_date: hdate,
          days_until: days_until
        })

        {:ok,  socket
        |> assign(:holidays, holidays)
        |> assign(:lookups, Holidays.list_lookups())
        |> assign(:error, nil)
      }
    else
      {:error, reason} ->


      end
  end


end
