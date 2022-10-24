defmodule ApiProjectWeb.UsersController do
  use ApiProjectWeb, :controller

  alias ApiProject.MiniProject01
  alias ApiProject.MiniProject01.Users

  action_fallback(ApiProjectWeb.FallbackController)

  def read(conn, _params, %{"userId" => id}) do
    user = User.get_user!(id)
  end

  def readCredentials(conn, %{"email" => email, "username" => username}) do
    user = User.get_user_by_credentials(%{email, username})
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %Users{} = user} <- User.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.users_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def update(conn, %{"userId" => id, "user" => user_params}) do
    user = User.get_user!(id)

    with {:ok, %Users{} = users} <- MiniProject01.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"userId" => id}) do
    user = MiniProject01.get_user!(id)

    with {:ok, %Users{}} <- MiniProject01.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end