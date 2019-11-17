defmodule Helper.MapHelper do
	def add_relation(struct, field, value) when is_nil(value) == false do
    struct
    |> Map.put(field, value)
	end

	def add_relation(struct, _field, _value), do: struct
end
