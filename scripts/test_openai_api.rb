require 'http'
require 'json'

api_key = 'sk-proj-mOoX18bP03rIZ70zalA0T3BlbkFJD6962pUF7bG6cQgaS80q'
prompt = 'Extract name and amount from: pay Nicole 100'

response = HTTP.post("https://api.openai.com/v1/chat/completions", headers: {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}, body: {
  model: "gpt-3.5-turbo",
  messages: [{ role: "system", content: "You are a helpful assistant." }, { role: "user", content: prompt }],
  max_tokens: 150
}.to_json)

puts "Full API response: #{response.body.to_s}"

parsed_response = JSON.parse(response.body.to_s)
if parsed_response['choices'] && parsed_response['choices'][0] && parsed_response['choices'][0]['message'] && parsed_response['choices'][0]['message']['content']
  puts parsed_response['choices'][0]['message']['content'].strip
else
  puts "Error: #{response.body.to_s}"
end

