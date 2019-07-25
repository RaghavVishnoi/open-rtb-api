class UserMailer < ApplicationMailer

	default from: 'test@example.com'
 
  def trigger_email(recipient, body)
	 	Liquid::Template.register_tag('random', Random)
		text = " {% random 2 %} you have drawn number ^^^, lucky you! "
	  @template = Liquid::Template.parse(text)
		puts @template.render  
		@username = 'Raghav'
	  mail(to: recipient, subject: 'Sample Subject')
	end 

end
