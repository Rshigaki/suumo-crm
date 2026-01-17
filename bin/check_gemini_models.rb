require "net/http"
require "json"
require "uri"
require "dotenv/load"

api_key = ENV["GEMINI_API_KEY"]
if api_key.nil? || api_key.empty?
  puts "GEMINI_API_KEY is not set."
  exit 1
end

uri = URI("https://generativelanguage.googleapis.com/v1beta/models?key=#{api_key}")
response = Net::HTTP.get_response(uri)

if response.is_a?(Net::HTTPSuccess)
  models = JSON.parse(response.body)["models"]
  puts "Available Models:"
  models.each do |model|
    puts "- #{model['name']} (Methods: #{model['supportedGenerationMethods']})"
  end
else
  puts "Error: #{response.code} - #{response.body}"
end
