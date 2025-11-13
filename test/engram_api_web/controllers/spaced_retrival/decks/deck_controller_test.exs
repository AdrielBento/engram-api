defmodule EngramAPIWeb.SpacedRetrival.Decks.DeckControllerTest do
  use EngramAPIWeb.ConnCase, async: false

  import EngramAPI.Factory

  describe "POST /decks" do
    test "creates a deck when params are valid", %{conn: conn} do
      collection = insert(:collection)
      params =
        params_for(:deck)
        |> Map.put(:collection_id, collection.id)

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(~p"/api/decks", Jason.encode!(params))
        |> json_response(201)

      assert %{
               "id" => id,
               "name" => name,
               "description" => description,
               "icon" => icon,
               "collection_id" => collection_id,
               "inserted_at" => inserted_at
             } = response

      assert is_binary(id)
      assert name == params.name
      assert description == params.description
      assert icon == params.icon
      assert collection_id == collection.id
      assert is_binary(inserted_at)
    end

    test "returns validation errors when params are invalid", %{conn: conn} do
      collection = insert(:collection)

      params =
        params_for(:deck)
        |> Map.put(:collection_id, collection.id)
        |> Map.drop([:name])

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(~p"/api/decks", Jason.encode!(params))
        |> json_response(422)

      assert %{"errors" => errors} = response

      assert [
               %{
                 "detail" => message,
                 "source" => %{"pointer" => "/name"},
                 "title" => "Invalid value"
               }
               | _rest
             ] = errors

      assert message =~ "Missing field: name"
    end
  end
end
