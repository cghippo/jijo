include( 'shared.lua' )  

  local ply = LocalPlayer() 
 
 
function GM:HUDPaint() 
         draw.RoundedBox(1, ScrW() - 1400 - 10, ScrH () - 30 - 10, 300, 20, Color(0, 0, 50, 205)) 
         
         // Health Bar Below 
         
         local DrawHealth = LocalPlayer():Health() or 0 
         local EchoHealth = LocalPlayer():Health() or 0 

         if DrawHealth > 250 then DrawHealth = 250 end 
         if DrawHealth < 0 then DrawHealth = 0 end 
         if DrawHealth == 0 then DrawHealth = 0 end 
         
         if DrawHealth !=  0 then 
                 draw.RoundedBox(1, ScrW() - 1400 - 10, ScrH () - 30 - 10, (300) * DrawHealth / 100, 20, Color(204, 0, 0, 255)) 
         end 

 
        draw.DrawText( team.GetName( ply:Team() ), "Trebuchet24", ScrW() - 1300, ScrH() - 100, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER ) 
end 


local ourMat = Material( "heart.png" ) -- Calling Material() every frame is quire expensive

hook.Add( "HUDPaint", "example_hook", function()
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.SetMaterial( ourMat ) -- If you use Material, cache it!
    surface.DrawTexturedRect( ScrW() - 1430, ScrH() - 38, 16, 16 )
end )

function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideOurHud:D", hidehud)


function GM:RenderScreenspaceEffects()
    if LocalPlayer():Team() == 0 then
     DrawTexturize( 3, Material("pp/texturize/rainbow.png"))
    end
end

// all the buttons I'm about to create are just a simple way to explain everything. I would make a table and make buttons that way but look through some more tutorials about loops till you do that.
local TeamMenu = vgui.Create( "DFrame" ) -- Creating the Vgui.
TeamMenu:SetPos( ScrW() +250, ScrH() / 2 -200 ) -- Setting the position of the menu.
TeamMenu:SetSize( 260, 210 ) -- Setting the size of the menu.
TeamMenu:SetTitle( "Team Selection" ) -- The menu title.
TeamMenu:ShowCloseButton( false ) -- Want us to see the close button? No.
TeamMenu:SetVisible( true ) -- Want it visible?
TeamMenu:SetDraggable( true ) -- Setting it draggable?
TeamMenu:MakePopup( ) -- And now we'll make it popup
function TeamMenu:Paint() -- This is the funny part. Let's paint it.
	draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Color( 0,0,0,200 ) ) -- This paints, and round's the corners etc.
end -- Now we ONLY end the painting function.
 
-- This is a part which I had to add for the fun sake.
 
if !TeamMenu.Open then --  If the menu is closed, then
	TeamMenu:MoveTo(ScrW() / 2 - 250,  ScrH() / 2 - 200, 1.6, 0,1) -- When you open it, it will slide trough the screen, not teleport.
end -- Ending the if statement
 
-- Button time.
local team_1 = vgui.Create( "DButton", TeamMenu ) //Creating the vgui of the button.
team_1:SetPos( 5, 30 ) -- Setting the position.
team_1:SetSize( 250, 30 ) -- Setting the size
team_1:SetText( "Jijo" ) -- Setting the text of the button
 
team_1.Paint = function() -- The paint function
    surface.SetDrawColor( 255, 50, 50, 255 ) -- What color do You want to paint the button (R, B, G, A)
    surface.DrawRect( 0, 0, team_1:GetWide(), team_1:GetTall() ) -- Paint what cords
end -- Ending the painting
 
team_1.DoClick = function() --Make the player join team 1
	RunConsoleCommand( "TEAM_1" )
	TeamMenu:Close() -- Close the DFrame (TeamMenu)
end -- Ending the button.
 
-- Now, this will be going on for 3 other buttons.
local team_2 = vgui.Create( "DButton", TeamMenu )
team_2:SetPos( 5, 70 )
team_2:SetSize( 250, 30 )
team_2:SetText( "Champs" )
 
team_2.Paint = function() -- The paint function
	surface.SetDrawColor( 50, 50, 255, 255 ) -- What color do You want to paint the button (R, B, G, A)
	surface.DrawRect( 0, 0, team_2:GetWide(), team_2:GetTall() ) -- Paint what cords (Used a function to figure that out)
end
 
team_2.DoClick = function() --Make the player join team 2
	RunConsoleCommand( "TEAM_2" )
	TeamMenu:Close()
end

-- Here we are, the close button. The last button for this, because this is used instead of ShowCloseButton( false )
local close_button = vgui.Create( "DButton", TeamMenu )
close_button:SetPos( 5, 185 )
close_button:SetSize( 250, 20 )
close_button:SetText( "Close this menu" )
 
close_button.Paint = function()
    draw.RoundedBox( 8, 0, 0, close_button:GetWide(), close_button:GetTall(), Color( 0,0,0,225 ) )
    surface.DrawRect( 0, 0, close_button:GetWide(), close_button:GetTall() )
end
 
close_button.DoClick = function()
    TeamMenu:Close()
end
-- Now we'll end the whole function.
concommand.Add("TeamMenu", TeamMenu) -- Adding the Console Command. So whenever you enter your gamemode, simply type TeamMenu in console.
 
