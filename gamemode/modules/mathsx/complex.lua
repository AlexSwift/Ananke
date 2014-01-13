mathsx.complex = {}

mathsx.complex.mt = {}
mathsx.complex.mt.__index = mathsx.complex.mt


function mathsx.complex.new( ... )

	local args = {...}
	local tabl = {}

	tabl.real = args[1] or 0
	tabl.imag = args[2] or 0

	return setmetatable( tabl , mathsx.complex.mt )

end

function mathsx.complex.mt:SetReal( num )

	self.real = num

end

function mathsx.complex.mt:SetImag( num )

	self.imag = num

end

function mathsx.complex.mt:GetReal( )

	return self.real

end

function mathsx.complex.mt:GetImag( )

	return self.imag

end

function mathsx.complex.mt:__add( b )

	local r = mathsx.complex.new()

	local real = self:GetReal() + b:GetReal()
	local imag = self:GetImag() + b:GetReal()

	r:SetReal( real )
	r:SetImag( imag )

	return r

end

function mathsx.complex.mt:__sub( b )

	local r = mathsx.complex.new()

	local real = self:GetReal() - b:GetReal()
	local imag = self:GetImag() - b:GetReal()

	r:SetReal( real )
	r:SetImag( imag )

	return r

end

function mathsx.complex.mt:__mul( b )

	local r = mathsx.complex.new( )

	local real = self:GetReal()*b:GetReal() - self:GetImag()*b:GetImag()
	local imag = self:GetReal()*b:GetImag() + self:GetImag()*b:GetReal()

	r:SetReal( real )
	r:SetImag( imag )

	return r

end

function mathsx.complex.mt:__div( b )

	local r = mathsx.complex.new()

	if type(b) == 'number' then

		local real = self:GetReal()/b
		local imag = b:GetReal()/b

		r:SetReal( real)
		r:SetImag( imag )

		return r

	else

		local conj = b:Conjugate()

		local real = self:GetReal()/( b * conj)
		local imag = b:GetReal()/( b * conj)

		r:SetReal( real)
		r:SetImag( imag )

		return r

	end

end

function mathsx.complex.mt:Conjugate()

	local r = mathsx.complex.new()

	r:SetReal( self:GetReal() )
	r:SetImag( -self:GEtImag() )

	return r

end

/*

function mathsx.complex.e( )

	local mt = table.Copy( mathsx.complex.mt )

	mt:__pow = function(b)

		local r = mathsx.complex.new()

		local real = b:GetReal() or b

		r:SetReal(

*/ --e^(a + bi) = (e^a)*(cos b + i*sin b)


