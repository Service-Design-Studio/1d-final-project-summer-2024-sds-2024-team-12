require "google/cloud/language"

class GoogleaiService
    def initialize
        @language = Google::Cloud::Language.language_service do |config|
        config.credentials = ENV['GOOGLE_CLOUD_CREDENTIALS']
        end
    end

    def analyze_text(text)
        response = @language.analyze_syntax(document: { content: text, type: :PLAIN_TEXT })
        tokens = response.tokens.map { |token| { text: token.text.content, part_of_speech: token.part_of_speech.tag } }
        tokens
    rescue StandardError => e
        Rails.logger.error "Google AI API Error: #{e.message}"
        nil
    end
end
