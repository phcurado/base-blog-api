defmodule Helper.PaginationHelper do
  defstruct [:data, :page, :size, :total]
  alias BaseBlog.Repo
  import Ecto.Query

  def page(query, page, size) when not(is_nil(page) or is_nil(size)) do
    data = query
    |> limit(^size)
    |> offset(^((page-1) * size))
    |> Repo.all()

    %Helper.PaginationHelper{
      data: data,
      page: page,
      size: size,
      total: total_data(query)
    }
  end

  def page(query, _page, _size) do
    query
    |> Repo.all()
  end

  defp total_data(query) do
    query
    |> exclude(:order_by)
    |> exclude(:preload)
    |> exclude(:select)
    |> select([e], count(e.id))
    |> Repo.one
  end
end