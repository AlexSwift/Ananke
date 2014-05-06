class 'Ananke.Language' {
	
	static {
	
		private {
		
			_LANGUAGES = {};
			Language = 'English';
			LanguageTable = {};
	
		};
		
		protected {
		
		};
		
		public {
		
			RegisterLanuage = function( self, l_name )
			
				if self._LANGUAGES[ l_name ] then
					Ananke.core.Debug:Error( 'Pre-existing language of name : ' .. l_name )
				end
				
				self._LANGUAGES[ l_name ] = {}
				
				return true
				
			end;
			
			AddPhraseToLanguage = function( self, l_name, l_identifier, l_phrase )
				
				if not self.LANGUAGES[ l_name ] then
					Ananke.core.Debug:Error( 'Invalid language name : ' .. l_name )
				end
				
				if self.LANGUAGES[ l_name ][ l_identifier ] then
					Ananke.core.Debug:Error( 'Phrase ' .. l_identifier .. ' already exists in the diction of ' .. l_name )
				end
				
				self.LANGUAGES[ l_name ][ l_identifier ] = l_phrase
				
			end;
			
			RegisterLanguageFromFile = function( self, l_name, file_name )
			
				if not self:RegisterLanguage( l_name ) then
					-- then ... it's already erroring
				end
			
				-- add some shit here later
				
			end;
				
			
			SetCurrentLanguage = function( self, l_name )
			
				if not self._LANGUAGES[ l_name ] then
					Ananke.core.Debug:Error( 'Invalid language name' )
				end
				
				self.Language = l_name
				self.LanguageTable = self._LANGUAGES[ l_name ]
				
			end;
			
			GetCurrentLanguage = function( self )	
				
				return self.Language 
				
			end;
			
			GetCurrentLanguageTable = function( self )
				
				return self.LanguagsTable
				
			end
			
			GetPhrase = function( self, l_phrase )
				
				if not self._LANGUAGES[ self.Language ] then
					Ananke.core.Debug:Error( 'Language in use not supported: WtF' )
				end
				
				if not self.LanguageTable[ l_phrase ] then
					Ananke.core.Debug:Error( 'Phrase not in diction for current language ' .. self.Language )
				end
				
				return self.LanguageTable[ l_phrase ]
			
			end;
					
		};
		
	};
};