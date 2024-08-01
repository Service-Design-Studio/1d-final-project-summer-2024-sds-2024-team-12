# app/services/openai_service.rb
require 'http'
require 'json'

class OpenaiService
  def initialize
    @api_key = ENV['OPENAI_API_KEY']
    Rails.logger.info "Using OpenAI API Key: #{@api_key}"
  end

  def generate_response(prompt)
    response = HTTP.post("https://api.openai.com/v1/chat/completions", headers: {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{@api_key}"
    }, body: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "system", content: "You are a helpful assistant." }, { role: "user", content: prompt }],
      max_tokens: 150
    }.to_json)

    Rails.logger.info("Full OpenAI API response: #{response.body.to_s}")

    parsed_response = JSON.parse(response.body.to_s)
    if parsed_response.dig('choices', 0, 'message', 'content')
      parsed_response['choices'][0]['message']['content'].strip
    else
      Rails.logger.error("OpenAI API response error: #{response.body.to_s}")
      nil
    end
  rescue => e
    Rails.logger.error("OpenAI API request failed: #{e.message}")
    nil
  end
end
