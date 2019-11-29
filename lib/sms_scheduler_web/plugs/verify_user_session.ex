defmodule SmsSchedulerWeb.Plugs.VerifyUserSession do
   import Plug.Conn
   #import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
   alias SmsScheduler.Users

   def init(opts) do
     opts
   end

   def call(conn, _opts) do
    user = get_session(conn, :user)
    if(user != nil) do
         if Users.get_user(user.id || -1) do
             assign(conn, :current_user, Users.get_user(user.id))
         end
    else
          conn
          |> assign(:current_user, nil)  
    end
   end
end