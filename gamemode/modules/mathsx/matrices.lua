mathsx.matrices = {}

mathsx.matrices.mt = {}
mathsx.matrices.mt.__index = mathsx.matrices.mt


function mathsx.matrices.new( ... )

	local tabl = {...}

	return setmetatable( tabl , mathsx.matrices.mt )

end

function mathsx.matrices.IdentityMatrix( m , n )

	local r = mathsx.matrices.new()
	r:SetDimentsions( m , m )

	for i = 1,m do
		r:SetData( i , i , n )
	end

	return r

end

function mathsx.matrices.InvertedMarix( m , n )

	local r = mathsx.matrices.new()
	r:SetDimensions(  m , m )

	for i = 0,m-1 do
		r:SetData( m - i , i)
	end

	return r

end

function mathsx.matrices.mt:SetDimensions( x , y )

	self.x = x
	self.y = y

	self.data = {}

	for i = 1, x do
		for j = 1, y do
			self.data[i][j] = 0
		end
	end

end

function mathsx.matrices.mt:SetData( x , y , v )

	if self.x < x or self.y < y then
		error( 'MATRIX: Out of bounds x, y' )
	end

	self.data[x][y] = v

end

function mathsx.matrices.mt:GetData( x , y )

	if self.x < x or self.y < y then
		error( 'MATRIX: Out of bounds x, y' )
	end

	return self[x][y]

end

function maths.matrices.mt:Determinant()

	if self.x != self.y then
		error( 'MATRIX: Matrix is not square' )
	end

	local s = 0

	for i = 1,self.x do
		local m = 1
		local n = 1
		for j = 1,self.y do
			m = m*self:GetData( math.mod( j + i, self.x) , math.mod( j , self.x ))
			n = n*self:GetData( math.mod( self.x - (i + j) , self.x ) , math.mod( j , self.x )
		end
		s = s + m - n
	end

	return s

end

function maths.matrices.mt:MinimumValue()

	local n

	for i = 1, self.x do
		for j = 1, self.y do
			n = self:GetData( i , j ) < n and n or n or self:GetData( i , j )
		end
	end

	return n

end

function mathsx.matrices.mt:__sub( b )

	if self.x != b.x or self.y != b.y then
		error( 'MATRIX: Unable to perform arithmetic operation')
	end

	local r = mathsx.matrices.new( )
	r:SetDimensions( self.x , self.x )

	for i = 1,self.x do
		for j = 1,self.y do
			r:SetData( i , j , self[i][j] - b[i][j] )
		end
	end

	return r

end

function mathsx.matrices.mt:__add( b )

	if self.x != b.x or self.y != b.y then
		error( 'MATRIX: Unable to perform arithmetic operation')
	end

	local r = mathsx.matrices.new( )
	r:SetDimensions( self.x , self.x )

	for i = 1,self.x do
		for j = 1,self.y do
			r:SetData( i , j , self[i][j] + b[i][j] )
		end
	end

	return r

end

function mathsx.matrices.mt:__mul( b )

	if type( b ) == 'number' then
		local n = b
		b = mathsx.matrices.IdentityMatrix( self.x , n )
	end

	if self.data.x != b.data.y or self.data.y != b.data.x then
		error( 'MATRIX: Unable to multiply matrices' )
	end

	-- a.x = b.y ; a.y = b.x

	local r = mathsx.matrices.new( )
	r:SetDimensions( self.y , b.x )

	for j = 1,self.y do
		for z = 1,b.y do
			local s = 0
			for i = self.y do
				s = s + self[i][j] * b[i][z]
			end
			r:SetData( i , j , s)
		end
	end

	return r

end

function mathsx.matrices.mt:__umn()

	return -1*self

end

function mathsx.matrices.mt:__div(d)  --Not working

	local det = b:Determinant()
	local min = b:MinimumValue()

	self = self * (( b - min)/det)

	return self

end


-- __div
-- a * ( 1 / b:Determinant )*( some mother fucking weird ass operation )


