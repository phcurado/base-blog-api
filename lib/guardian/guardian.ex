defmodule BaseBlog.Guardian do
    use Guardian, otp_app: :base_blog
    alias BaseBlog.Accounts.User
  
    def subject_for_token(%User{} = user, _claims) do
      sub = to_string(user.id)
      {:ok, sub}
    end

    def subject_for_token(_, _) do
      {:error, :reason_for_error}
    end
  
    def resource_from_claims(claims) do
      id = claims["sub"]
      resource = BaseBlog.Accounts.get_user!(id)
      {:ok,  resource}
    end

    def resource_from_claims(_claims) do
      {:error, :reason_for_error}
    end
  end