require 'httparty'

class DeepLTranslator
  include HTTParty
  base_uri 'https://api-free.deepl.com/v2'

  def initialize(api_key)
    @api_key = api_key
  end

  def translate(text, target_lang)
    options = {
      body: {
        auth_key: @api_key,
        text:,
        target_lang:
      }
    }

    self.class.post('/translate', options)
  end
end
