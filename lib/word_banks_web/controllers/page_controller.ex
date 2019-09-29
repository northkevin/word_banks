defmodule WordBanksWeb.PageController do
  use WordBanksWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
