defmodule SmsScheduler.Scheduler.Schedule do
    use Ecto.Schema
    import Ecto.Changeset
    

    schema "schedule" do
        field :to, :string
        field :from, :string
        field :body, :string
    end

    def send_message(to, from, body) do
        #to: m.to, from: "+18573204133", body: m.body]
        IO.puts "attempting to send sched message"
        resp = ExTwilio.Message.create(to: to, from: "+18573204133", body: body)
        IO.inspect resp
        resp
    end
end
