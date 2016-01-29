def login_helper(user)
  post "/auth/login", params: { email: user.email, password: user.password },
       headers: { ACCEPT: "application/vnd.matbucketlist.v1+json" }
end
