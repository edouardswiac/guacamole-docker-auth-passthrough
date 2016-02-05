# usage connect.rb RDP_HOST RDP_USER RDP_PASSWORD GUAC_HOST
require 'net/http'
require 'uri'
require 'json'

remote_host = ARGV[0] 
username = ARGV[1]
password = ARGV[2]
guac_host = ARGV[3] ||= "http://192.168.99.100:8080/guacamole" 

params = {
	:protocol => "rdp", 
	:username => username, 
	:password => password, 
	:security => "nla", 
	"ignore-cert" => "true",
	:hostname => remote_host }

puts "creating guac config for #{params.inspect}" 
uri = URI.parse(guac_host+"/api/tokens")
response = Net::HTTP.post_form(uri, params)
response_json = JSON.parse(response.body)
token = response_json["authToken"]

puts "#{guac_host}/#/?token=#{token}" 
