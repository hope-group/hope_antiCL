local webhook = ""



RegisterCommand("combat", function(source, args, rawcmd)
    TriggerClientEvent("pixel_antiCL:show", source)
end)

AddEventHandler("playerDropped", function(reason)
    local crds = GetEntityCoords(GetPlayerPed(source))
    local id = source
    local identifier = ""
    identifier = GetPlayerIdentifier(source, 1)
    end
    TriggerClientEvent("pixel_anticl", -1, id, crds, identifier, reason)
    if Config.LogSystem then
        SendLog(id, crds, identifier, reason)
    end
end)

function SendLog(id, crds, identifier, reason)
    local name = GetPlayerName(id)
    local date = os.date('*t')
    print("id:"..id)
    print("X: "..crds.x..", Y: "..crds.y..", Z: "..crds.z)
    print("identifier:"..identifier)
    print("reason:"..reason)
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    local date = (''..date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec..'')
    local embeds = {
        {
            ["title"] = "Jogador desconectou",
            ["type"]="rich",
            ["color"] = 4777493,
            ["fields"] = {
                {
                    ["name"] = "Identificador",
                    ["value"] = identifier,
                    ["inline"] = true,
                },{
                    ["name"] = "Nome",
                    ["value"] = name,
                    ["inline"] = true,
                },{
                    ["name"] = "ID do jogador",
                    ["value"] = id,
                    ["inline"] = true,
                },{
                    ["name"] = "Coordenadas",
                    ["value"] = "X: "..crds.x..", Y: "..crds.y..", Z: "..crds.z,
                    ["inline"] = true,
                },{
                    ["name"] = "Motivo",
                    ["value"] = reason,
                    ["inline"] = true,
                },
            },
            ["footer"]=  {
                ["icon_url"] = "https://forum.fivem.net/uploads/default/original/4X/7/5/e/75ef9fcabc1abea8fce0ebd0236a4132710fcb2e.png",
                ["text"]= "Sent: " ..date.."",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = Config.LogBotName,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end