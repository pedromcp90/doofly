defmodule Doofly.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  @hash_id_regex ~r/^[A-z0-9_-]{8,45}$/

  @primary_key {:id, :integer, []}
  schema "links" do
    field :url, :string
    field :hash, :string
    field :visits, :integer

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :hash, :visits])
    |> validate_required([:url, :hash])
    |> validate_url(:url)
    |> validate_format(:hash, @hash_id_regex)
  end

  def validate_url(changeset, field, options \\ %{}) do
    validate_change(changeset, field, fn :url, url ->
      uri = URI.parse(url)

      if uri.scheme == nil do
        [{field, options[:message] || "Please enter valid url!"}]
      else
        []
      end
    end)
  end
end
