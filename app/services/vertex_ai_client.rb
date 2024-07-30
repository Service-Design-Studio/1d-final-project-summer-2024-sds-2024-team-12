# app/services/vertex_ai_service.rb
require 'google/cloud/ai_platform'

class VertexAIService
  def initialize
    @client = Google::Cloud::AIPlatform.endpoint_service
  end

  def predict_and_categorize(query)
    # Assume `predict` method returns an AI categorization based on the query
    response = predict(query, ENV['VERTEX_AI_ENDPOINT_ID'])
    case response.category
    when 'change_limit', 'find_limit'
      'local_transfer_limit'
    else
      'default_path'
    end
  end
end
