defmodule Helper.PaginationHelper do
  import Plug.Conn
  import Ecto.Query

  def page(query, page, size) when not(is_nil(page) or is_nil(size)) do
    query
    |> limit(^size)
    |> offset(^((page-1) * size))
  end

  def page(query, _page, _size) do
    query
  end
end