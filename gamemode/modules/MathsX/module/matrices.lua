class 'Ananke.MathsX.Matrices' {

	public {
	
		InvertedMarix = function( m , n )

			local r = Ananke.MathsX.Matrices()
			r:SetDimensions(  m , m )
		
			for i = 0, m-1 do
				r:SetData( m - i , i)
			end
		
			return r
		
		end;
		
		LaplaceCofactor = function( m )
			
			local r = Ananke.MathsX.Matrices()
			r:SetDimensions( m , m )
			
			for i = 1, m^2 do
			
				local x = i%m
				local y = (i - i%m)/i
				
				r:SetData( x, y, (-1)^(i - 1) )
				
			end
			
			return r
				
		end;
		
	};
	
	protected {
		
		SetDimensions = function( self, x , y )
		
			self.x = x
			self.y = y
		
			self.data = {}
		
			for i = 1, x do
				for j = 1, y do
					self.data[i][j] = 0
				end
			end
		
		end;
		
		SetData = function( self, x, y, value )

			if self.x < x or self.y < y then
				error( 'MATRIX: Out of bounds x, y' )
			end
		
			self.data[x][y] = value
		
		end;
		
		GetData = function( self, x, y )

			if self.x < x or self.y < y then
				error( 'MATRIX: Out of bounds x, y' )
			end
		
			return self[x][y]
		
		end;
		
		Determinant = function( self )
		
			if self.x != self.y then
				error( 'MATRIX: Matrix is not square' )
			end
		
			local s = 0
		
			for i = 1,self.x do
				local m = 1
				local n = 1
				for j = 1,self.y do
					m = m*self:GetData( math.mod( j + i, self.x) , math.mod( j , self.x ) )
					n = n*self:GetData( math.mod( self.x - (i + j) , self.x ) , math.mod( j , self.x ) )
				end
				s = s + m - n
			end
		
			return s
		
		end;
		
		MinimumValue = function( self )

			local n 
		
			for i = 1, self.x do
				for j = 1, self.y do
					n = n and self:GetData( i , j ) < n and self:GetData( i , j ) or self:GetData( i , j )
				end
			end
		
			return n
		
		end;
		
		Square = function( self )
			
			return self.x == self.y and true or false
			
		end;
		
		SubMatrix = function( self, x, y )
		
			local r = Ananke.MathsX.Matrices()
			r:SetDimensions( self.x - 1, self.y - 1 )
		
			local j = 1
			local k = 1
		
			for i = 1, x*y do
				
				local t_x = i%x
				local t_y = (i- i%x)/i
				
				if t_x == x or t_y == y then continue end
				
				r:SetData( j, k, self:GetData( t_x, t_y ) )
				
				if i < ( self.x - 1 ) then
					j = j + 1
				else 
					j = 1
					k = k + 1
				end
				
			end
			
			return r
			
		end;
				
		
		Determinant = function( self )
			
			if not self:Square() then return end
			
			local lpcf = Ananke.MathsX.Matrices.LaplaceCofactor( self.x )
			local detm = 0
			
			for i = 1, self.x do
				detm = detm + ((-1)^(i - 1))*self:SubMatrix( i, 1 ):Determinant() 
			end
			
			return detm
			
		end;	
		
	};

	meta {
		__sub = function( self, b )

			if self.x != b.x or self.y != b.y then
				error( 'MATRIX: Unable to perform arithmetic operation')
			end
		
			local r = Ananke.MathsX.Matrices( )
			r:SetDimensions( self.x , self.x )
		
			for i = 1,self.x do
				for j = 1,self.y do
					r:SetData( i , j , self[i][j] - b[i][j] )
				end
			end
		
			return r
		
		end;
		
		__add = function( self, b )
		
			if self.x != b.x or self.y != b.y then
				error( 'MATRIX: Unable to perform arithmetic operation')
			end
		
			local r = Ananke.MathsX.Matrices( )
			r:SetDimensions( self.x , self.x )
		
			for i = 1,self.x do
				for j = 1,self.y do
					r:SetData( i , j , self[i][j] + b[i][j] )
				end
			end
		
			return r
		
		end;
		
		__mul = function( self, b )
		
			if type( b ) == 'number' then
				local n = b
				b = mathsx.matrices.IdentityMatrix( self.x , n )
			end
		
			if self.data.x != b.data.y or self.data.y != b.data.x then
				error( 'MATRIX: Unable to multiply matrices' )
			end
		
			-- a.x = b.y ; a.y = b.x
		
			local r = Ananke.MathsX.Matrices( )
			r:SetDimensions( self.y , b.x )
		
			for j = 1,self.y do
				for z = 1,b.y do
					local s = 0
					for i = 1,self.y do
						s = s + self[i][j] * b[i][z]
					end
					r:SetData( i , j , s)
				end
			end
		
			return r
		
		end;
		
		__umn = function( self )

			return -1*self

		end;
		
		__div = function( self, d )  --Not Implemented
			/*
			local det = b:Determinant()
			local min = b:MinimumValue()
		
			self = self * (( b - min)/det)
		
			return self
			*/
			
		
		end
		
	};
	
	private {
	
		x = 0;
		y = 0;
		data = {};
			
	};

}
