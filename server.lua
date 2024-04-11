local VORPcore = exports.vorp_core:GetCore()

RegisterServerEvent("lto_pendu:jobcheck", function(target_id)
    local Character = VORPcore.getUser(source).getUsedCharacter
    local job = Character.job
    
    for k, v in pairs(Config.Jobs) do
        if job == Config.Jobs[k] then
            TriggerClientEvent('lto_pendu:AnimLevier', source)
            TriggerClientEvent('lto_pendu:sethang', target_id)
        else
            TriggerClientEvent('vorp:TipRight', source, 'You don\'t have the required job to do this!', 4000)
        end
    end
end)