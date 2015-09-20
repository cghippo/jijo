local ply = FindMetaTable( "Player" )

function ply:SetGamemodeTeam( n )
	if n < 0 or n > 1 then return false end

	self:SetTeam( n )

	if n == 0 then
		self:SetPlayerColor(Vector( 1.0, .2, .2 ) )
	elseif n == 1 then
		self:SetPlayerColor(Vector( .2, .2, 1.0 ) )
	end

	return true
end
