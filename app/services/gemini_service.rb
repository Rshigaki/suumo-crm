require "faraday"
require "faraday/retry"

class GeminiService
  API_ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent"

  def initialize(api_key: ENV["GEMINI_API_KEY"])
    @api_key = api_key
  end

  def summarize(text, context: nil)
    return "API Key not set" if @api_key.blank?
    return "No text provided" if text.blank?

    conn = Faraday.new(url: API_ENDPOINT) do |f|
      f.request :json
      f.response :json
      f.request :retry, max: 3, interval: 0.1, backoff_factor: 2
      f.adapter Faraday.default_adapter
    end

    prompt = build_prompt(text, context)
    
    response = conn.post do |req|
      req.params["key"] = @api_key
      req.headers["Content-Type"] = "application/json"
      req.body = {
        contents: [{
          parts: [{ text: prompt }]
        }]
      }
    end

    if response.success?
      extract_content(response.body)
    else
      "Error: #{response.status} - #{response.body}"
    end
  rescue StandardError => e
    "API Error: #{e.message}"
  end

  private

  def build_prompt(text, context)
    "以下の接客会話ログを要約し、重要な商談ポイント、顧客の要望、および次回のアクション（TODO）を箇条書きで抽出してください。\n\n" \
    "【会話ログ】\n#{text}\n\n" \
    "【出力フォーマット】\n" \
    "■要約\n(ここに要約)\n\n" \
    "■顧客の要望・懸念\n(ここにリスト化)\n\n" \
    "■次回アクション\n(ここにTODO)"
  end

  def extract_content(body)
    body.dig("candidates", 0, "content", "parts", 0, "text") || "No content generated"
  end
end
