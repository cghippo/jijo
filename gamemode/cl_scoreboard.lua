--[[

  Scoreboard for JiJo
  By LittleBigBug

]]


  function GAMEMODE:ScoreboardShow()
  end



surface.CreateFont( "JiJoH", {
  font = "Trebuchet",
  size = 28,
  weight = 650,
  antialias = true,
})

surface.CreateFont( "JiJoH2", {
  font = "Trebuchet",
  size = 18,
  weight = 650,
  antialias = true,
})

surface.CreateFont( "JiJo28", {
  font = "Trebuchet",
  size = 28,
  weight = 550,
  antialias = true,
})

surface.CreateFont( "JiJo18", {
  font = "Trebuchet",
  size = 18,
  weight = 450,
  antialias = true,
})

local function createPlayers( t, f )

  if not t then return end

  for k, v in pairs( team.GetPlayers( t ) ) do

    local plp = vgui.Create( "DPanel", f or nil )
    plp:SetSize( f:GetWide()-4, 30 )
    plp:SetPos( f:GetWide()/2-plp:GetWide()/2, 10+k*32 )
    plp.Paint = function( self, w, h )
      surface.SetFont( "JiJoH2" )
      local tw, th = surface.GetTextSize( "TEXT" )
      draw.RoundedBox( 4, 0, 0, w, h, team.GetColor( t ) )
      local text = (v:Nick() or "")
      local tw2, th2 = surface.GetTextSize( text )
      draw.SimpleText( text, "JiJoH2", 33, 30/2-th/2, color_white, TEXT_ALIGN_LEFT )
      local text = (v:Ping() or 0 or "")
      draw.SimpleText( tostring( text ), "JiJoH2", plp:GetWide()-5, 30/2-th/2, color_white, TEXT_ALIGN_RIGHT )
      local aw = v:GetActiveWeapon()
      local w1 = aw:GetPrintName()
      local text = w1
      draw.SimpleText( text, "JiJoH2", tw2+33+25, 30/2-th/2, color_white, TEXT_ALIGN_LEFT )
    end

    local ai = vgui.Create( "AvatarImage", plp )
    ai:SetSize(25, 25)
    ai:SetPos( 5, plp:GetTall()/2-25/2 )
    ai:SetPlayer( v, 32 )

  end

end

local function inQuad( fraction, beginning, change )
	return change * ( fraction ^ 2 ) + beginning
end

local function drawScoreboard()

  m = vgui.Create( "DFrame" )
  m:SetSize(ScrW()-(ScrW()/4), (ScrH()-ScrH()/4))
  m:Center()
  m:SetTitle( "" )
  m:ShowCloseButton( false )
  m:SetDraggable( false )
  m:SetZPos( 100 )

  local d1 = vgui.Create( "DPanel", m )
  d1:SetPos(0, 40)
  d1:SetSize( m:GetWide()/2, m:GetTall()-35 )
  d1.Paint = function( self, w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color(70, 70, 70, 240) )
    draw.RoundedBox( 0, 0, 0, w, 40, Color( 30, 30, 30, 240 ) )
    local text = (team.GetName( TEAM_JIJOS or TEAM_JIJO or 2 ) or "")
    surface.SetFont( "JiJo28" )
    local tw, th = surface.GetTextSize( text )
    draw.SimpleText( text, "JiJo28", self:GetWide()/2, 3, color_white, TEXT_ALIGN_CENTER )
    draw.RoundedBox( 2, w-2, 40, 2, h-40, Color( 30, 30, 30, 240 ) )
  end

  createPlayers( (TEAM_JIJOS or TEAM_JIJO or 2), d1 )

  local d2 = vgui.Create( "DScrollPanel", m )
  d2:SetPos(m:GetWide()/2, 40)
  d2:SetSize( m:GetWide()/2, m:GetTall()-35 )
  d2.Paint = function( self, w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color(70, 70, 70, 240) )
    draw.RoundedBox( 0, 0, 0, w, 40, Color( 30, 30, 30, 240 ) )
    local text = (team.GetName( TEAM_CHAMP or TEAM_CHAMPS or 1 ) or "")
    surface.SetFont( "JiJo28" )
    local tw, th = surface.GetTextSize( text )
    draw.SimpleText( text, "JiJo28", self:GetWide()/2, 3, color_white, TEXT_ALIGN_CENTER )
  end

  createPlayers( (TEAM_CHAMP or TEAM_CHAMPS or 1), d2 )

  local tb2 = vgui.Create( "DScrollPanel", m )
  tb2:SetPos(0, 0)
  tb2:SetSize(m:GetWide(), 40)
  tb2.Paint = function( self, w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color( 69, 69, 69, 0 ) )
    local text = "JiJo Gamemode Developed by [CG]Hippo"
    draw.SimpleText( text, "JiJo18", 5, 4, color_white, TEXT_ALIGN_LEFT )
          text = "www.github.com/cghippo"
    draw.SimpleText( text, "JiJo18", self:GetWide()-4, 4, color_white, TEXT_ALIGN_RIGHT )
  end

  m.Paint = function( self, w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color( 69, 69, 69, 0 ) )
    local text = (GetHostName() or "JiJo Server")
    draw.SimpleText( text, "JiJoH", self:GetWide()/2, 0, color_white, TEXT_ALIGN_CENTER )
  end

end

local function hideScoreboard()
  if m then m:Close() end
end

hook.Add( "ScoreboardShow", "jijo_scoreboardshow", drawScoreboard )
hook.Add( "ScoreboardHide", "jijo_scoreboardhide", hideScoreboard )
