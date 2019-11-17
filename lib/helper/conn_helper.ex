defmodule Helper.ConnHelper do
  import Plug.Conn
  
  def get_pagination_page(conn) do
    get_page_value(conn, "page", 1)
  end
  
  def get_pagination_size(conn) do
    get_page_value(conn, "size", 10)
  end

  def get_page_value(conn, value, default_value) do
    page_from_header = get_req_header(conn, value)
    case Enum.empty?(page_from_header) do
      true ->
        default_value
      false ->
        [page | _] = page_from_header
        page |> String.to_integer()
    end
  end
end