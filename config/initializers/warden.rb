require Rails.root.join('lib/strategies/azure_ad_json_web_token_strategy')
Warden::Strategies.add(:azure_ad_json_web_token, AzureAdJsonWebTokenStrategy)