# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EngramAPI.Repo.insert!(%EngramAPI.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EngramAPI.Repo
alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.{Card, Collection, Deck}

# This configuration drives the seeds that will be inserted. Update the
# quantities or templates to customise the generated data quickly.
seed_config = %{
  collections: %{
    quantity: 2,
    template: %{
      name: "Learning Path %{collection_index}",
      description: "Collection %{collection_index} with curated topics.",
      icon: "collection-%{collection_index}"
    }
  },
  decks: %{
    quantity: 3,
    template: %{
      name: "Deck %{collection_index}-%{deck_index}",
      description: "Deck %{deck_index} for collection %{collection_index}.",
      icon: "deck-%{collection_index}-%{deck_index}"
    }
  },
  cards: %{
    quantity: 4,
    template: %{
      question: "Question %{collection_index}-%{deck_index}-%{card_index}?",
      answer: "Answer %{collection_index}-%{deck_index}-%{card_index}."
    }
  }
}

%{
  collections: collections_cfg,
  decks: decks_cfg,
  cards: cards_cfg
} = seed_config

stringify = fn value ->
  case value do
    v when is_binary(v) -> v
    v -> to_string(v)
  end
end

replace_placeholders = fn value, replacements ->
  case value do
    string when is_binary(string) ->
      Enum.reduce(replacements, string, fn {key, replacement}, acc ->
        String.replace(acc, "%{" <> Atom.to_string(key) <> "}", stringify.(replacement))
      end)

    fun when is_function(fun, 1) ->
      fun.(replacements)

    other ->
      other
  end
end

apply_template = fn template, replacements ->
  Enum.reduce(template, %{}, fn {key, value}, acc ->
    Map.put(acc, key, replace_placeholders.(value, replacements))
  end)
end

Repo.transaction(fn ->
  Enum.each(1..collections_cfg.quantity, fn collection_index ->
    collection_replacements = %{collection_index: collection_index}

    collection_attrs =
      apply_template.(collections_cfg.template, collection_replacements)

    collection =
      %Collection{}
      |> Collection.changeset(collection_attrs)
      |> Repo.insert!()

    deck_base_replacements =
      Map.put(collection_replacements, :collection_name, collection_attrs.name)

    Enum.each(1..decks_cfg.quantity, fn deck_index ->
      deck_replacements =
        deck_base_replacements
        |> Map.put(:deck_index, deck_index)

      deck_attrs =
        decks_cfg.template
        |> apply_template.(deck_replacements)
        |> Map.put(:collection_id, collection.id)

      deck =
        %Deck{}
        |> Deck.changeset(deck_attrs)
        |> Repo.insert!()

      card_base_replacements =
        deck_replacements
        |> Map.put(:deck_name, deck_attrs.name)

      Enum.each(1..cards_cfg.quantity, fn card_index ->
        card_replacements =
          card_base_replacements
          |> Map.put(:card_index, card_index)

        card_attrs =
          cards_cfg.template
          |> apply_template.(card_replacements)
          |> Map.put(:deck_id, deck.id)

        %Card{}
        |> Card.changeset(card_attrs)
        |> Repo.insert!()
      end)
    end)
  end)
end)

IO.puts("Seed data inserted successfully.")
