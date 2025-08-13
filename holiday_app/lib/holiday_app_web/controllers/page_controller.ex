defmodule HolidayAppWeb.PageController do
  use HolidayAppWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
