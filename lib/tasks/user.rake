namespace :user do
  desc "Send email to users"
  task send_email: :environment do
  	rtb_response_list = RtbResponse.all
  	rtb_response_list.each do |rtb_response|
  		puts rtb_response
  		rtb_response.destroy
  	end
  end

end
