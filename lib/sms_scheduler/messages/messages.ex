defmodule SmsScheduler.Messages do
    import Ecto.Query, warn: false
    alias SmsScheduler.Repo
    alias SmsScheduler.Users.User
    alias SmsScheduler.Messages.Message
    use DynamicSupervisor

    def list_messages do
        Repo.all(Message) |> Repo.preload(:user)
    end

    def recent_messages(nn) do
        Repo.all from mm in Message,
          order_by: [desc: mm.inserted_at],
          preload: [:user],
          limit: ^nn
    end

    def get_message(id) do
        Repo.one! from m in Message,
          where: m.id == ^id,
          preload: [:user]
    end

    def create_message(attrs \\ %{}) do
        #TODO: from_number should be available here without db query

        message = %Message{}
        |> Message.changeset(attrs)


        IO.inspect message
        m = message.changes

        # IO.puts ExTwilio.Config.account_sid()
        # IO.puts ExTwilio.Config.api_domain()
        # IO.puts ExTwilio.Config.api_version()
        # IO.puts ExTwilio.Config.auth_token()
        resp =  
        if m.send_now do
            #m.send_time = Timex.now("America/New_York")
            ExTwilio.Message.create(to: m.to, from: "+18573204133", body: m.body)
        else
            IO.inspect m.send_time
            {:ok, sched_time} = DateTime.from_naive(m.send_time, "America/New_York")
            IO.inspect sched_time
            curr_time = Timex.now("America/New_York")
            IO.inspect curr_time
            diff = Timex.compare(sched_time, curr_time)
            IO.puts diff
            if diff < 1 do
                IO.puts "past date entered"
                {:error, "Cant be scheduled. Past date entered."}
            else
                IO.puts "scheduling the sms"
                fun = &ExTwilio.Message.create/3
                IO.inspect fun
                
                #p = SchedEx.run_in(SmsScheduler.Scheduler.Schedule, :send_message, [to: m.to, from: "+18573204133", body: m.body], 1000)
                #p = SchedEx.run_in(IO, :puts, ["hello"], 1000);
                #fun  = %{id: "scheduled-task-twilio", start: {SchedEx, :run_in, [IO, :puts, ["hello"], 1000]} }
                fun  = %{id: "scheduled-task-twilio", start: {SchedEx, :run_at, 
                [SmsScheduler.Scheduler.Schedule, :send_message, [m.to, "+18573204133", m.body], sched_time]},
                restart: :temporary }
                opts = [strategy: :one_for_one]
                #IO.inspect Supervisor.start_link([fun], opts)
                sup = SmsScheduler.Supervisor
                p = Supervisor.start_child(sup, fun)
                IO.inspect p
                # sup = Supervisor.supervisor()
                # DynamicSupervisor.start_child(sup, &1)

                #IO.inspect p
            end
        end
        IO.inspect resp
        
        case resp do 
        {:ok, _resp} ->
            message
            |> Repo.insert()
        {:error, _resp} ->
            IO.puts "Error sending SMS"
        _ = resp -> 
            IO.puts "whatever"
        end
    end

    
    def delete_message(%Message{} = message) do
        Repo.delete(message)
    end

    def new_message do
        Message.changeset(%Message{}, %{})
    end
    
end