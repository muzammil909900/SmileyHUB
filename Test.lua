return function(context, players)
    if not context.Executor:IsAdmin() then
        return "You are not allowed to use this command"
    end
    -- otherwise, grant seeds
end
