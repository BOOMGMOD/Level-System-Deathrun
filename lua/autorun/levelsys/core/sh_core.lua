<<<<<<< HEAD
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
=======
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
>>>>>>> origin/master
