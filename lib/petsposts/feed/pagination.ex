defmodule Petsposts.Feed.Pagination do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Petsposts.Feed.Pagination

  @default_order :inserted_at
  @default_dir :desc

  embedded_schema do
    field :order_by, Petsposts.AtomType, default: @default_order
    field :order_dir, Petsposts.AtomType, default: @default_dir
    field :page, :integer, default: 1
    field :page_size, :integer, default: 10
    field :total_items, :integer, default: 0
    field :total_pages, :integer, default: 0
  end

  def default_order, do: @default_order

  def default_dir, do: @default_dir

  def from_attrs(attrs) do
    pagination = %Pagination{}
    |> cast(attrs, [:page, :page_size, :order_by, :order_dir, :total_items])
    |> validate_inclusion(:order_by, [:inserted_at, :likes, :views])
    |> validate_inclusion(:order_dir, [:desc, :asc])
    |> validate_number(:page, greater_than: 0)
    |> validate_number(:page_size, greater_than: 0)
    |> validate_number(:total_items, greater_than_or_equal_to: 0)
    pages = trunc(get_field(pagination, :total_items) / get_field(pagination, :page_size))
    pagination = pagination
    |> change(total_pages: pages)
    |> validate_number(:total_items, greater_than_or_equal_to: 0)

    case pagination.valid? do
      true ->  {:ok, apply_changes pagination}
      _ -> {:error, pagination}
    end
  end

  def page(query, %Pagination{} = pagination) do
    query
    |> order_by([{^pagination.order_dir ,^pagination.order_by}])
    |> limit(^pagination.page_size)
    |> offset(^((pagination.page - 1) * pagination.page_size))
  end

  def toggle_order_dir(:desc), do: :asc
  def toggle_order_dir(:asc), do: :desc
  def toggle_order_dir(val) when is_binary(val), do: toggle_order_dir(String.to_atom val)
end
