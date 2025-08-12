defmodule Amdryzen9600xWeb.ErrorJSONTest do
  use Amdryzen9600xWeb.ConnCase, async: true

  test "renders 404" do
    assert Amdryzen9600xWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Amdryzen9600xWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
