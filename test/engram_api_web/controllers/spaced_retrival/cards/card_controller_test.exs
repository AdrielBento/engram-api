defmodule EngramAPIWeb.SpacedRetrival.Cards.CardControllerTest do
  use EngramAPIWeb.ConnCase, async: false

  import EngramAPI.Factory

  describe "POST /cards" do
    test "creates a card when params are valid", %{conn: conn} do
      collection = insert(:collection)
      deck = insert(:deck, collection: collection)

      params =
        params_for(:card)
        |> Map.put(:deck_id, deck.id)

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(~p"/api/cards", Jason.encode!(params))
        |> json_response(201)

      assert %{
               "id" => id,
               "question" => question,
               "answer" => answer,
               "deck_id" => deck_id,
               "state" => state,
               "step" => step,
               "stability" => stability,
               "difficulty" => difficulty,
               "scheduled_days" => scheduled_days,
               "due" => due,
               "last_review" => last_review,
               "inserted_at" => inserted_at
             } = response

      assert is_binary(id)
      assert question == params.question
      assert answer == params.answer
      assert deck_id == deck.id
      assert state == "learning"
      assert step == 0
      assert is_nil(stability)
      assert is_nil(difficulty)
      assert is_nil(scheduled_days)
      assert is_binary(due)
      assert is_nil(last_review)
      assert is_binary(inserted_at)
    end

    test "returns validation errors when params are invalid", %{conn: conn} do
      collection = insert(:collection)
      deck = insert(:deck, collection: collection)

      params =
        params_for(:card)
        |> Map.put(:deck_id, deck.id)
        |> Map.drop([:question])

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(~p"/api/cards", Jason.encode!(params))
        |> json_response(422)

      assert %{"errors" => errors} = response

      assert [
               %{
                 "detail" => message,
                 "source" => %{"pointer" => "/question"},
                 "title" => "Invalid value"
               }
               | _rest
             ] = errors

      assert message =~ "Missing field: question"
    end
  end
end
