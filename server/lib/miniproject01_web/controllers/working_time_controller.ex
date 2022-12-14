defmodule ApiProjectWeb.WorkingTimeController do
  use ApiProjectWeb, :controller

  alias ApiProject.WorkingTime
  alias ApiProject.User

  action_fallback(ApiProjectWeb.FallbackController)

  def readAll(conn, %{"userId" => userId, "end" => end_datetime, "start" => start_datetime}) do
    working_times =
      WorkingTime.get_working_time_by_user(%{
        user_id: userId,
        start: start_datetime,
        end: end_datetime
      })

    render(conn, "index.json", working_times: working_times)
  end

  def readOne(conn, %{"id" => id, "userId" => userId}) do
    user = User.get_user(userId)


    if user do
      working_time = WorkingTime.get_working_time_by_user!(%{id: id, user_id: userId})

      IO.inspect(working_time)
      if working_time do
        render(conn, "show.json", working_time: working_time)
      else
        conn
        |> put_status(404)
        |> render("error.json", reason: "Working time not found")
      end
    else
      conn
      |> put_status(404)
      |> render("error.json", reason: "User not found")
    end
  end

  def create(conn, %{"working_time" => working_time_params, "userId" => user_id}) do
    with {:ok, %WorkingTime{} = working_time} <-
           WorkingTime.create_working_time(
             Map.merge(working_time_params, %{"user_id" => user_id})
           ) do
      conn
      |> put_status(:created)
      |> render("show.json", working_time: working_time)
    end
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = WorkingTime.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <-
           WorkingTime.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = WorkingTime.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- WorkingTime.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
