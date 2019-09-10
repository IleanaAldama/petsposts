defmodule PetspostsWeb.PostView do
  alias Petsposts.Feed.Pagination
  use PetspostsWeb, :view

  def path(conn, opts \\ []) do
    {query_order_by, query_order_dir, query_page} = get_order_from_query(conn)
    query = [
      page: Keyword.get(opts, :page, query_page),
      order_by: Keyword.get(opts, :order_by, query_order_by),
      order_dir: Keyword.get(opts, :order_dir, query_order_dir)
    ]
    Routes.post_path(conn, :index, query)
  end

  def current_order_dir(conn) do
    {_, query_order_dir, _} = get_order_from_query(conn)
    query_order_dir
  end

  def next_order_dir(conn) do
    query_order_dir = current_order_dir(conn)
    Pagination.toggle_order_dir(query_order_dir)
 end

  def get_order_from_query(conn) do
    params = conn
    |> Plug.Conn.fetch_query_params()
    |> Map.get(:query_params)
    query_order_by = Map.get(params, "order_by", Pagination.default_order)
    query_order_dir = Map.get(params, "order_dir", Pagination.default_dir)
    query_page = Map.get(params, "page", 1)
    {query_order_by, query_order_dir, query_page}
  end

end
