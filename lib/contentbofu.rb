class ContentBofu

	def initialize
		# Just the defaults that I use.
		@tbs_method = 'replaceEveryonesFavorites'
		@tbs_maxsyns = '7'
		@tbs_quality = '1'
	end

	def madlib(body)

		# Replaces {}, {|},{|||||||||}, etc
		body.gsub!(/(\{\}|\{\|*\})/,'')

		while true do 
			vars = body.scan(/\{[^\{\}]+?\}/)

			if vars.count == 0
		            # No more madlib eval's, break out
			    break;
			end


			# Evaluate the spintax on the run
			vars.each do |ind|
		   		parts = ind.gsub(/(\{|\})/,'').split(/\|/)
		   		body.gsub!(ind,parts[rand(parts.size)])
			end

		end

		return body

	end


	# TBS User Definition & Setting
	def tbs_user
                return @tbs_user
        end

	def tbs_user=(value)
		@tbs_user = value
	end


	# TBS Password Definition & Setting
        def tbs_pass
                return @tbs_pass
        end

	def tbs_pass=(value)
		@tbs_pass = value
	end


	# TBS Method Definition & Setting
	def tbs_method
		return @tbs_method
	end
	def tbs_method=(value)
		@tbs_method = value
	end

	# TBS Quality Definition & Setting - Quality only applies for the method replaceEveryonesFavorites
        def tbs_quality
                return @tbs_quality
        end
        def tbs_quality=(value)
                @tbs_quality = value
        end

	# TBS Maxsyns (Max Synonyms) Definition & Setting - Quality only applies for the method replaceEveryonesFavorites
        def tbs_maxsyns
                return @tbs_maxsyns
        end
        def tbs_maxsyns=(value)
                @tbs_maxsyns = value
        end


	# TBS Spin
	def tbs_spin(body)

		require 'rubygems'
		require 'mechanize'
		require 'php_serialize'

		if (@tbs_user == nil) || (@tbs_pass == nil)
			raise "Your username (tbs_user) or password (tbs_pass) are unset."
		end


		api_url = "http://thebestspinner.com/api.php"
		
		# Set basics to establish the session
		data = Hash.new
		data['action'] = 'authenticate'
		data['format'] = 'php'
		data['username'] = @tbs_user
		data['password'] = @tbs_pass

		agent = Mechanize.new
		session_info = PHP.unserialize(agent.post(api_url,data).content)

		# If the "session" is set correctly, continue		
		if session_info['success'] == "true"

			data = Hash.new
			data['session'] = session_info['session']
			data['format'] = 'php'
			data['text'] = body
			data['action'] = @tbs_method
			if @tbs_method == 'replaceEveryonesFavorites'
				data['maxsyns'] = @tbs_maxsyns
				data['quality'] = @tbs_quality
			end

			# Post & Get Result
			spin_return = PHP.unserialize(agent.post(api_url,data).content)

			# Return just the output (still in spintax, NOT evaluated)
			return spin_return['output']

		end

	end

end
