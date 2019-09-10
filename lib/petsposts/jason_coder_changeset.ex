defimpl Jason.Encoder, for: [Ecto.Changeset] do

  def encode(changeset, opts) do
    errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
    Jason.Encode.map(errors, opts)
  end
end
