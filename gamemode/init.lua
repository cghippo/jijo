AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )

include( 'shared.lua' )
include("player.lua")


// Serverside only stuff goes here

/*---------------------------------------------------------
   Name: gamemode:PlayerLoadout( )
   Desc: Give the player the default spawning weapons/ammo
---------------------------------------------------------*/
/*
function GM:PlayerLoadout( pl )

pl:GiveAmmo( 255,	"pistol", 		true )


 if pl:Team() == 0 then
	pl:Give( "explosive_fists" )
	pl:StripWeapon( "weapon_pistol" )
else
	pl:Give( "weapon_pistol" )
	pl:StripWeapon( "explosive_fists" )
 end
end*/

function GM:PlayerInitialSpawn( ply )
	for k, ply in pairs( player.GetAll() ) do
		PrintMessage( HUD_PRINTTALK, ply:Nick().. " has joined the server!" )
	end

	
	ply:SetGamemodeTeam( math.random( 0, 1 ) )
end

/*
function GM:PlayerSetModel( ply )
if ply:Team() == 0 then
	ply:SetModel("models/player/demon_violinist/demon_violinist.mdl")
else
	ply:SetModel("models/player/group01/male_07.mdl")
 end
end*/

local weapon = { "weapon_357", "weapon_gravgun", "weapon_ar2"}
hook.Add( "PlayerDeath", "Death", function(ply, attacker, dmg)
	for k, weapon in pairs(weapon) do
		attacker:Give( weapon )
	end
end )

hook.Add( "PlayerDeath", "Death", function(ply, attacker, dmg)
	for k, weapon in pairs(weapon) do
		ply:Give( weapon )
	end
end )

function GM:PlayerSpawn( ply )
	if ply:Team() == 0 then
		ply:SetJumpPower( 1500 )
	else
		ply:SetJumpPower( 300 )
	end

	ply:GiveAmmo( 255,	"pistol", 		true )
	if ply:Team() == 0 then
	ply:Give( "explosive_fists" )
	ply:StripWeapon( "weapon_pistol" )
		else
	ply:Give( "weapon_pistol" )
	ply:StripWeapon( "explosive_fists" )
 	end

 	if ply:Team() == 0 then
 		ply:SetHealth( 250 )
 	else
 		ply:SetHealth( 100 )
 	end

 	if ply:Team() == 0 then
		ply:SetModel("models/player/demon_violinist/demon_violinist.mdl")
	else
		ply:SetModel("models/player/group01/male_07.mdl")
    end

    if ply:Team() == 0 then
    	ply:SetRunSpeed( 1000 )
    	ply:SetWalkSpeed( 500 )
    else
    	ply:SetRunSpeed( 350 )
    	ply:SetWalkSpeed( 200 )
    end
    
    ply:SetupHands()
end

function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

function GM:PlayerDeath( victim, inflictor, attacker )
	PrintMessage( HUD_PRINTTALK, victim:Name() .. " was killed by " .. attacker:Name() .. "." )
end

function GM:GetFallDamage( ply, speed )
	return ( speed / 500 )
end

// You can make a simple function using arguements to make this less messier but this would be the simplest way to explain what it does.	
function TEAM_1( ply ) -- Creating the function.
	ply:UnSpectate() -- As soon as the person joins the team, he get's Un-spectated
	ply:SetTeam( 0 ) -- We'll set him to team 1
	ply:Spawn() -- Let's spawn him.
	ply:Flashlight( true )
	ply:AllowFlashlight( true )
end -- End the function
concommand.Add("TEAM_1", TEAM_1) -- Adding a concommand (Console Command) for the team.
 
 
function TEAM_2( ply )
	ply:UnSpectate()
	ply:SetTeam( 1 )
	ply:Spawn()
	ply:Flashlight( true )
	ply:AllowFlashlight( true )
end
concommand.Add("TEAM_2", TEAM_2)
