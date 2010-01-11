require 'rubygems'
require 'sinatra'
require 'json'
require 'tlsmail'
require 'time'

get '/' do 
  "Pachube Target Handling Service"
end

post '/api/v1' do
  body = JSON.parse(params[:body])

  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
  Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'pachutarget@gmail.com', 'foobar99', :login) do |smtp|
    smtp.open_message_stream('pachutarget@gmail.com', 'kitplummer@gmail.com') do |f|
      f.puts 'From: pachutarget@gmail.com'
      f.puts 'To: kitplummer@gmail.com'
      f.puts "Subject: #{body['environment']['title']} exceeded a threshold."
      f.puts "Date: #{Time.now.rfc2822}" 
      f.puts
      f.puts "#{body['environment']['title']} #{body['environment']['feed']} exceeded a threshold."
      f.puts "Time reported: #{body['timestamp']}"
      f.puts "Threshold: #{body['threshold_value']}"
      f.puts "Reported Value: #{body['triggering_datastream']['value']['current_value']}"
    end
  end
end