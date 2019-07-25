class Adapter
	class << self


		def call
			HTTParty.post(url, 
	    :body => body.to_json,
	    :headers => header )
		end

		def url
			open_rtb_config['url']
		end

		def open_rtb_config
			PROPERTY_CONFIG['open_rtb']
		end

		def body( data = {}, native = {} )			
			native[:id] = open_rtb_config['main']['id']
			native[:imp] = imp			
			native[:site] = site_details
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

	end
end