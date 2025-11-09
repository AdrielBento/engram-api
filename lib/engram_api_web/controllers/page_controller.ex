defmodule EngramAPIWeb.PageController do
  use EngramAPIWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
