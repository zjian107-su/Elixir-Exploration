defmodule AppWeb.GithubAuthController do
  use AppWeb, :controller

  @doc """
  `index/2` handles the callback from GitHub Auth API redirect.
  """
  def index(conn, %{"code" => code}) do
    IO.inspect(code, label: "code index/2:8")
    IO.puts("Hello, World! DANIEL!!!!!!!!!!")
    {:ok, profile} = ElixirAuthGithub.github_auth(code)
    # {:error, profile} = ElixirAuthGithub.github_auth(code)

    IO.inspect(profile)
    IO.puts(profile)

    conn
    |> put_view(AppWeb.PageView)
    |> render(:welcome, profile: profile)

  end
end
