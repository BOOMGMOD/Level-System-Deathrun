function levelsys.initPlayer(ply)
	print("Intializing Player Data...")
	ply.levelsys = {}
	ply.levelsys.xp = 0
    ply.levelsyslvl = {}
	ply.levelsyslvl = levelsys.configdatabase.findlvl(ply)
	print(ply.levelsyslvl.lvlnum)
    print(ply.levelsyslvl.name)
	timer.Simple(5, function()
		if levelsys.database.fetch(ply) then
			print("Getting Data...")
			ply.levelsys = levelsys.database.fetch(ply)
			ply.levelsyslvl.lvlnum = tonumber(ply.levelsyslvl.lvlnum)
            ply.levelsyslvl.name = tostring(ply.levelsyslvl.name)
			ply.levelsys.xp = tonumber(ply.levelsys.xp)
			BroadcastData(ply)
		else
			levelsys.database.add(ply)
			print("Adding Player...")
			ply.levelsys = levelsys.database.fetch(ply)
			ply.levelsyslvl.lvlnum = tonumber(ply.levelsyslvl.lvlnum)
            ply.levelsyslvl.name = tostring(ply.levelsyslvl.name)
			ply.levelsys.xp = tonumber(ply.levelsys.xp)
			BroadcastData(ply)
		end
	end)
	BroadcastData(ply)
end

function BroadcastData(ply)
	net.Start("levelsys_data")
		net.WriteEntity(ply)
		net.WriteTable(ply.levelsys)
	net.Broadcast()
end


function levelsys.AddXP(ply, amount)
	if not ply.levelsys then return end
    if tonumber( ply.levelsyslvl.lvlnum ) >= LevelSysConfig.LevelCap then return end
	ply.levelsys.xp = ply.levelsys.xp + amount
	--levelsys.hud.AddNotification(ply, "XP Gained! +" .. amount .. " XP", Color(205,255,0))
	levelsys.database.save(ply)
	BroadcastData(ply)
end

function levelsys.RemoveXP(ply, amount)
	if not ply.levelsys then return end
	ply.levelsys.xp = ply.levelsys.xp - amount
	--levelsys.hud.AddNotification(ply, "XP Losted, -" .. amount .. " XP", Color(205,255,0))
	levelsys.database.save(ply)
	BroadcastData(ply)
end


concommand.Add("levelsys_addxp", function(ply, cmd, args)
	if ply:IsUserGroup("superadmin") then
	for _, p in pairs(player.GetAll()) do
		if p:SteamID() == args[1] and args[2] then
			MsgC(Color(205,255,0), "XP given to " .. p:Nick() .. " in amount of " .. args[2] .. "\n")
			levelsys.AddXP(p, args[2])
		else
			MsgC(Color(255,95,115), "XP not given, no player found or no amount of XP specified.")
		end
	end
	end
end)

concommand.Add("levelsys_removexp", function(ply, cmd, args)
	if ply:IsUserGroup("superadmin") then
	for _, p in pairs(player.GetAll()) do
		if p:SteamID() == args[1] and args[2] then
			MsgC(Color(205,255,0), "XP removed to " .. p:Nick() .. " in amount of " .. args[2] .. "\n")
			levelsys.RemoveXP(p, args[2])
		else
			MsgC(Color(255,95,115), "XP not removed, no player found or no amount of XP specified.")
		end
	end
	end
end)


/*function levelsys.FindLvlc(ply)
	ply.getlvl = {}
	ply.getlvl = levelsys.configdatabase.findlvl(ply)
	print(ply.getlvl.lvlnum)
end*/

--Net Messages--
util.AddNetworkString("levelsys_data")

--Hooks--
hook.Add("PlayerInitialSpawn", "levelsys_initplayer", levelsys.initPlayer)
hook.Add("PlayerInitialSpawn", "levelsys_Findlvl", levelsys.FindLvlc)

--Gain XP Hooks--
hook.Add( "PlayerDeath", "levelsys_killXP", function(victim, inflictor, attacker)
	if victim:IsPlayer() and attacker:IsPlayer() then
		levelsys.AddXP( attacker, LevelSysConfig.KillXP )
	end
end )

hook.Add( "DeathrunRoundWin", "levelsys_winXP", function(winner)
	for k,v in ipairs( player.GetAll() ) do
			if v:Team() == winner then
				levelsys.AddXP(v, LevelSysConfig.WinXP)
			end
	end
end )

hook.Add( "DeathrunPlayerFinishMap", "levelsys_finishedXP", function(ply, name, zone, place, seconds)
    if place == 1 then
    levelsys.AddXP(ply, LevelSysConfig.FirstXP)
    elseif place == 2 then
    levelsys.AddXP(ply, LevelSysConfig.SecondXP)
    elseif place == 3 then
    levelsys.AddXP(ply, LevelSysConfig.ThirdXP)
    elseif place == 4 then
    levelsys.AddXP(ply, LevelSysConfig.FourthXP)
    elseif place == 5 then
    levelsys.AddXP(ply, LevelSysConfig.FifthXP)
    else
    levelsys.AddXP(ply, LevelSysConfig.CompletedXP)
    end
end )
