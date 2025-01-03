local TIMEOUT = 2

local NewStates = 
{
    State{
        name = "name",
        tags = {"attack", "notalking", "abouttoattack", "busy"},
        server_states = {"name"},
     
        onenter = function(inst)
            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(TIMEOUT)
        end,

        ontimeout = function(inst)
            inst:ClearBufferedAction()
            inst.sg:GoToState("idle", true)
        end,


        onupdate = function(inst, dt)
        end,
     
        timeline=
        {
            TimeEvent(n*FRAMES, function(inst)
            end),
        },

        events=
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
        end,
    }
}

for _,state in pairs(NewStates) do
    AddStategraphState("wilson_client", state)
end