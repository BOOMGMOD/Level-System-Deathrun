/*------------------------------------------------------------ADDING/REMOVING RANKS-----------------------------------------------------------------
When adding/changing ranks in the lvling system you have to go down to the function levelsys.configdatabase.insert and put the ranks in that you 
want with lvlnum being the level in number form (0 being the rank that people are when they join), name being the ranks text name, lowxp being the
starting value for the xp, and highxp being the value right before you reach the next rank (Say it takes 1000 xp to get to the 5th rank and and 1500 
for the 6th rank, for the 5th ranks value you would have lvlnum be 4 {being that it is the tecnical 4th rank, i.e. 0(First Rank), 1(Second Rank), 
2(Third Rank), 3(Fourth Rank), 4(Fifth Rank),... }, the name be whatever you want, lowxp be 1000, and high xp be 1499.)

To redo the Levelsys ranks if you messed up you would-
1. Uncomment levelsys_levelconfig_database_delete hook
2. Comment out levelsys_levelconfig_database_checklvl hook
3. Restart/Start server
4. Shut Down Server
5. Fix/Change The Rank Values
6. Comment out levelsys_levelconfig_database_delete hook
7. Uncomment levelsys_levelconfig_database_checklvl hook
8. Then they should be fixed/changed :)

IMPORTANT, ONLY RUN levelsys_levelconfig_database_delete HOOK IF YOU WANT TO REDO THE RANKS, THIS HOOK WILL REMOVE ALL DATA FROM levelsys_data TABLE

In Short, try not to get it wrong the first time :)
--------------------------------------------------------------------------------------------------------------------------------------------------*/
levelsys = {}
levelsys.database = {}
levelsys.configdatabase = {}

function levelsys.database.query( query )
	local query = sql.Query( sql.SQLStr( query, true ) )

	if not query and sql.LastError() then
		print( "SQL Error: " ..  sql.LastError() )
	else
		if type( query ) == "table" and table.Count( query ) == 1 then
			query = query[ 1 ]
		end
	end

	return query
end

function levelsys.database.init()
	if not sql.TableExists( "levelsys_players" ) then
		levelsys.database.query( "CREATE TABLE levelsys_players ( id INTEGER, xp INTEGER )" )
	end
end

function levelsys.database.fetch( ply )
	return levelsys.database.query( "SELECT * FROM levelsys_players WHERE id = " .. ply:SteamID64() )
end

function levelsys.database.add( ply )
	levelsys.database.query( "INSERT INTO levelsys_players ( id, xp ) VALUES ( " .. ply:SteamID64() .. ", 0 )" )
end

function levelsys.database.save( ply )
	levelsys.database.query( "UPDATE levelsys_players SET xp = " .. ply.levelsys.xp .. " WHERE id = " .. ply:SteamID64() )
end

function levelsys.configdatabase.init()
	if not sql.TableExists( "levelsys_data" ) then
		levelsys.database.query( "CREATE TABLE levelsys_data ( lvlnum INTEGER, name STRING, lowxp INTEGER, highxp INTEGER )" )
	end
end

function levelsys.configdatabase.checklvl() 
	levelsysdata = {}
    levelsysdata = levelsys.database.query( "SELECT lvlnum FROM levelsys_data" )
    if not levelsysdata then
    levelsys.configdatabase.insert()
    end
end

function levelsys.configdatabase.insert()
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 0, 'Noob', 0, 499 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 1, 'Learning', 500, 649 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 2, 'Rookie', 650, 836 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 3, 'Regular', 837, 2377 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 4, 'Skilled', 2378, 5649 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 5, 'Awesome', 5650, 11833 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 6, 'Amazing', 11834, 22568 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 7, 'Champion', 22569, 40028 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 8, 'Lord', 40029, 67007 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 9, 'OverLord', 67008, 107000 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 10, 'MVP', 107001, 164286 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 11, 'Boss', 164287, 244015 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 12, 'Elite', 244016, 496268 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 13, 'Professional', 496269, 925645 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 14, 'Brutal', 925646, 1231352 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 15, 'Mystic', 1231353, 1613545 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 16, 'Unbeatable', 1613546, 2085917 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 17, 'Insane', 2085918, 2663741 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 18, 'Sonic', 2663742, 3363963 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 19, 'Legendary', 3363964, 4205292 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 20, 'God', 4205293, 6407402 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 21, 'Immortal', 6407403, 12814805 )" )
	sql.Query( "INSERT INTO levelsys_data ( lvlnum, name, lowxp, highxp ) VALUES ( 22, 'The Real Sanic', 12814806, 12814806 )" )
end

function levelsys.configdatabase.delete()
	levelsys.database.query( "DELETE FROM levelsys_data" )
end

function levelsys.configdatabase.findlvl( ply )
    return levelsys.database.query( "SELECT lvlnum AND name FROM levelsys_data, ( SELECT xp FROM levelsys_players WHERE id = " .. ply:SteamID64() .. " )tmp WHERE tmp.xp >= lowxp AND tmp.xp <= highxp" )
end

/*---------------------------------------------------------------------------
	Hooks
---------------------------------------------------------------------------*/
hook.Add( "Initialize", "levelsys_database_init", levelsys.database.init )
hook.Add( "Initialize", "levelsys_levelconfig_database_init", levelsys.configdatabase.init )
hook.Add( "Initialize", "levelsys_levelconfig_database_checklvl", levelsys.configdatabase.checklvl )
--hook.Add( "Initialize", "levelsys_levelconfig_database_delete", levelsys.configdatabase.delete )
