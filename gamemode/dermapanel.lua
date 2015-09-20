if SERVER then
	-- Server Side Stuff
	util.AddNetworkString("F1_Menu")

	function F1Menu( ply )
		net.Start("F1_Menu")
			--empty
		net.Send(ply)	
	end
	hook.Add( "ShowHelp", "CoolioName", F1Menu )

elseif CLIENT then
	
	function openF1Menu()
		local f = vgui.Create("Dframe")
		f:SetSize( 256 + 64, 256 + 64 )
		f:SetTitle( "Help Menu" )
		f:SetVisible( true )
		f:SetDraggable( true )
		f:ShowCloseButton( true )
		f:MakePopup()
		f:Center()

		local icon = vgui.Create( "DModelPanel", f ) 
		icon:SetPos( 32, 32 )
		icon:SetSize( 256, 256 )
		icon:SetModel( LocalPlayer():GetModel() )

	end

	net.Receive( "F1_Menu", function(len)
		openF1Menu()
	end)

end