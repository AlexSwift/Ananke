--[[

IDEA: When I get round to creating the Ananke.Player object,
add a true extend operator for SimplOO to add functionality
without the hastle of modifying the actual class it's self.

]]

class 'Ananke.core.Flags' {

	static {
	
		private {
		
			_FLAGS = {}
			
		},
		
		protected {
		
			CreateClass = function( self, class )
				
				if self._FLAGS[ class ] then
					Ananke.Debug:Error( 'Attempted to overwrite pre-existing flags class' )
					return false
				end
				
				self._FLAGS[ class ] = { }
				
				return true
				
			end,
			
			CreateFlag = function( self, class, name, id )
			
				if not self._FLAGS[ class ] then
					self._FLAGS = self.FLAGS or {}
				end
			
				if self._FLAGS[ class ][ id ] then
					Ananke.Debug:Error( 'Attempted to create flag with existing ID ' .. id )
					return false
				end
				
				self._FLAGS[ class ][ id ] = { FL_NAME = name, FL_ID = id }
				
				return true
				
			end,
			
			GetFlag = function( self, class, id )
			
				if not self._FLAGS[ class ] then
					Ananke.Debug:Error( 'Flags class does not exist' )
					return nil
				end
				
				if not self._FLAGS[ class ][ id ] then
					Ananke.Debug:Error( 'Attempted to reference inexistant flag ' .. id )
					return nil
				end
				
				return self._FLAGS[ id ]
				
			end,
			
			GetClassFlags = function( self, class )
				
				if not self._FLAGS[ class ] then
					Ananke.Debug:Error( 'Flag class table does not exist' )
					return nil
				end
				
				return self._FLAGS[ class ] 
				
			end,
			
			GetFlagByName = function( self, class, name )
				 
				for k,v in pairs( self:GetClassFlags( class ) ) do
					if v.FL_NAME == name then
						return v
					else
						continue
					end
				end
				
				Ananke.Debug:Error( 'Attempted to reference inexistant flag ' .. name )
				
				return nil
			
			end
		
		},
		
	},

	private {
	
		Flags = 0 --I will try this as a number first, should be ok.
		Class = ''
		
		__construct = function( self, class )
		
			-- class might not be initialised in terms of flags.
			
			if not self._FLAGS[ class ] then
				Ananke.core.Debug:Error( 'Class has not yet been initialised ' .. class )
				return nil
			end
			
			self.Class = class
			
			
		end
	
	},
	
	protected {
	
		GetClass = function( self )
			
			return self.Class
			
		end,
	
		SetFlag = function( self, FL_NAME, bool )
		
			--local class = self:GetClass() --BAD!
			local FL_BIT = 2^( self:GetFlagByName( FL_NAME ).FL_ID )
			
			if self.Flags % (FL_BIT + FL_BIT) >= FL_BIT  then -- value is set
				self.Flags = self.Flags
			else
				self.Flags = Self.Flags + ( bool and FL_BIT or -FL_BIT )
			end
			
		end,
		
		
		HasFlag = function( self, FL_NAME )
			
			local FL_BIT = 2^( self:GetFlagByName( FL_NAME ).FL_ID )
			
			if bit.band( self.Flags , FL_BIT ) == FL_BIT then
				return true
			end
			
			return false
			
		end,
			
			
	
	},
	
	public {
	
	}
	
}