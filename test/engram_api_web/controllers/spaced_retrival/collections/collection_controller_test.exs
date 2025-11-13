defmodule EngramAPIWeb.SpacedRetrival.Collections.CollectionControllerTest do
  use EngramAPIWeb.ConnCase, async: false

  import EngramAPI.Factory

  describe "POST /collections" do
    test "creates a collection when params are valid", %{conn: conn} do
      params = params_for(:collection)

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(~p"/api/collections", Jason.encode!(params))
        |> json_response(201)

      assert %{
               "id" => id,
               "name" => name,
               "description" => description,
               "icon" => icon,
               "inserted_at" => inserted_at
             } = response

      assert is_binary(id)
      assert name == params.name
      assert description == params.description
      assert icon == params.icon
      assert is_binary(inserted_at)
    end

    test "returns validation errors when params are invalid", %{conn: conn} do
      params = params_for(:collection) |> Map.delete(:name)

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(~p"/api/collections", Jason.encode!(params))
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
