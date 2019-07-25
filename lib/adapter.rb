class Adapter
	class << self


		def call
			combinations = age_grade_combinations
			combinations.each do |combination|
				# response = HTTParty.post(url, 
		  #   :body => body(combination[0], combination[1]).to_json,
		  #   :headers => header )
				response = File.read('/home/raghav/Desktop/Response.json')
				push_to_queue(JSON.parse(response))
			end
		end

		def push_to_queue(response)
			puts response
			id = response['id']
			bidid = response['bidid']
			cur = response['cur']
			seatbid = response['seatbid']
			puts seatbid
			rtb_response = RtbResponse.find_or_create_by(main_id: id)
			rtb_response.update(bidid: bidid, cur: cur, seatbid: seatbid)
		end

		def url
			open_rtb_config['url']
		end

		def open_rtb_config
			PROPERTY_CONFIG['open_rtb']
		end

		def body( age, grade, data = {}, native = {} )			
			native[:id] = open_rtb_config['main']['id']
			native[:imp] = imp			
			native[:site] = site_details
			native[:age] = age
			native[:grade] = grade
			native
		end

		def header
			{ 'Content-Type' => open_rtb_config['content_type'] }
		end

		def imp( data = {} )
			data[:id] = open_rtb_config['main']['tmp_id']
			data[:tagid] = open_rtb_config['main']['tag_id']
			data[:native] = native
			Array.wrap(data)
		end

		def native( data = {} )
			data[:ver] = 1
			data[:request] = request
			data
		end

		def request( native = {} )
			native[:native] = request_native
			native
		end

		def request_native( native = {} )
			native[:ver] = open_rtb_config['request']['version']
			native[:plcmtcnt] = open_rtb_config['request']['plcmtcntversion']
			native[:seq] = open_rtb_config['request']['seq']
			assets = PROPERTY_CONFIG['sample_assets'].values
			native[:assets] = assets
			native
		end

		def site_details( site = {}, published = {} )
			site[:id] = open_rtb_config['request']['site_id']
			site[:domain] = open_rtb_config['request']['domain']
			published[:id] = open_rtb_config['request']['publisher_id']
			site[:published] = published 
			site
		end

		def age_grade_combinations
			age = open_rtb_config['age']
			grades = open_rtb_config['grades']
			age.product(grades)
		end

	end
end