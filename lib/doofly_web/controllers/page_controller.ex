defmodule DooflyWeb.PageController do
  use DooflyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", shortened_link: "")
  end
end
