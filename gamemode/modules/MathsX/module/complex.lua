class "Ananke.MathsX.Complex" {
	
	private {
		
		real = 0;
		imag = 0
		
	};
	
	protected {
		
		__construct = function(self, real, imag)
			self.real = real or 0
			self.imag = imag or 0
		end;
		
		__finalize = function(self)

		end;
		
		SetReal = function( self, num )
			self.real = num
		end;
		
		GetReal = function( self )
			return self.real or 0
		end;
		
		SetImag = function( self, num )
			self.imag = num
		end;
		
		GetImag = function( self )
			return self.imag
		end;
		
		Conjugate = function( self )

			local r = Ananke.MathsX.Complex()
		
			r:SetReal( self:GetReal() )
			r:SetImag( -self:GEtImag() )
		
			return r
		
		end;
		
		Matrix = function( self )
	
			if !Ananke.MathsX.Matrices then return nil end
			
			local r = Ananke.MathsX.Matrices()
			local real = self:GetReal()
			local imag = self:GetImag()
			
			r:Setdimensions( 2 , 2 )
			
			r:SetData( 1 , 1 , real )
			r:SetData( 1 , 2 , -imag )
			r:SetData( 2 , 1 , imag )
			r:SetData( 2 , 2 , real )
			
			return r
		
		end;
		
	};
	
	meta {
		__add = function( self, b )
			local r = Ananke.MathsX.Complex()

			local real = self:GetReal() + b:GetReal()
			local imag = self:GetImag() + b:GetReal()

			r:SetReal( real )
			r:SetImag( imag )

			return r
		end;

		__sub = function( self, b )

			local r = Ananke.MathsX.Complex()
		
			local real = self:GetReal() - b:GetReal()
			local imag = self:GetImag() - b:GetReal()
		
			r:SetReal( real )
			r:SetImag( imag )
		
			return r
		
		end;

		__mul = function( self, b )

			local r = Ananke.MathsX.Complex( )
		
			local real = self:GetReal()*b:GetReal() - self:GetImag()*b:GetImag()
			local imag = self:GetReal()*b:GetImag() + self:GetImag()*b:GetReal()
		
			r:SetReal( real )
			r:SetImag( imag )
		
			return r
		
		end;

		__div = function( self, b )
		
			local r = Ananke.MathsX.Complex()
		
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
		
		end;

	}
	
}





