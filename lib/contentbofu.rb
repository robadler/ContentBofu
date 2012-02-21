class ContentBofu

	def initialize
		# Just the defaults that I use.
		@tbs_method = 'replaceEveryonesFavorites'
		@tbs_maxsyns = '7'
		@tbs_quality = '1'
	end

	def madlib(body)

		# Replaces {}, {|},{|||||||||}, etc
		output = body.gsub(/(\{\}|\{\|*\})/,'')
		#srand(Time.now.nsec + rand(999999999999999))	
	

		while true do 
			vars = output.scan(/\{[^\{\}]+?\}/)

			if vars.count == 0
		            # No more madlib eval's, break out
			    break;
			end


			# Evaluate the spintax on the run
			vars.each do |ind|
		   		parts = ind.gsub(/(\{|\})/,'').split(/\|/)
		   		output = output.gsub(ind,parts[rand(parts.size)])
			end

		end

		return output

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

  # TBS User Definition & Setting
  def wai_user
    return @wai_user
  end

	def wai_user=(value)
		@wai_user = value
	end


	# WordAI Password Definition & Setting
  def wai_pass
    return @wai_pass
  end

	def wai_pass=(value)
		@wai_pass = value
	end

  # WordAI Slider Value
  def wai_slider
    return @wai_slider
  end

	def wai_slider=(value)
		@wai_slider = value
	end

  # WordAI Protected Words (no spaces, separated by commas)
  def wai_protected
    return @wai_protected
  end

	def wai_protected=(value)
		@wai_protected = value
	end

  # WordAI Speed Value (on = no nested)
  def wai_speed
    return @wai_speed
  end

	def wai_speed=(value)
		@wai_speed = value
	end

  # WordAI No Original Setting - on = Do NOT return original word back.
  def wai_nooriginal
    return @wai_nooriginal
  end

	def wai_nooriginal=(value)
		@wai_nooriginal = value
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

  def wai_spin(body)

    require 'rubygems'
		require 'mechanize'
		require 'php_serialize'

    if (@wai_user == nil) || (@wai_pass == nil) || (@wai_slider == nil) || (body == nil)
			raise "You have not set your username (@wai_user), password (@wai_pass), slider value (@wai_slider) or Body."
		end

    agent = Mechanize.new

    api_url = "http://beta.wordai.com/spinit.php"

    data = Hash.new
    data['s'] = body
    data['slider'] = @wai_slider
    data['api'] = "true"
    data['email'] = @wai_user
    data['pass'] = @wai_pass
    data['speed'] = @wai_speed if @wai_speed != nil
    data['protected'] = @wai_protected if @wai_protected != nil
    data['nooriginal'] = @wai_nooriginal if @wai_nooriginal != nil


    # Post & Get Result
		spin_return = agent.post(api_url,data).content

		# Return (still in spintax, NOT evaluated)
	  return spin_return


  end

end
