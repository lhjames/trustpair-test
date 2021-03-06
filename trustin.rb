require 'json'
require 'net/http'

class TrustIn
  def initialize(evaluations)
    @evaluations = evaluations
  end

  def update_score()
    @evaluations.each do |evaluation|
      if evaluation.type == "SIREN"
        if evaluation.score > 0 && evaluation.state == "unconfirmed" && evaluation.reason == "ongoing_database_update"
          uri = URI("https://public.opendatasoft.com/api/records/1.0/search/?dataset=sirene_v3" \
            "&q=#{evaluation.value}&sort=datederniertraitementetablissement" \
            "&refine.etablissementsiege=oui")
          response = Net::HTTP.get(uri)
          parsed_response = JSON.parse(response)
          company_state = parsed_response["records"].first["fields"]["etatadministratifetablissement"]
          if company_state == "Actif"
            evaluation.state = "favorable"
            evaluation.reason = "company_opened"
            evaluation.score = 100
          else
            evaluation.state = "unfavorable"
            evaluation.reason = "company_closed"
            evaluation.score = 100
          end
        elsif evaluation.score >= 50
          if evaluation.state == "unconfirmed" && evaluation.reason == "unable_to_reach_api"
            evaluation.score = evaluation.score - 5
          elsif evaluation.state == "favorable"
            evaluation.score = evaluation.score - 1
          end
        elsif evaluation.score <= 50 && evaluation.score > 0
          if evaluation.state == "unconfirmed" && evaluation.reason == "unable_to_reach_api" || evaluation.state == "favorable"
            evaluation.score = evaluation.score - 1
          end
        else
          if evaluation.state == "favorable" || evaluation.state == "unconfirmed"
            uri = URI("https://public.opendatasoft.com/api/records/1.0/search/?dataset=sirene_v3" \
                      "&q=#{evaluation.value}&sort=datederniertraitementetablissement" \
                      "&refine.etablissementsiege=oui")
            response = Net::HTTP.get(uri)
            parsed_response = JSON.parse(response)
            company_state = parsed_response["records"].first["fields"]["etatadministratifetablissement"]
            if company_state == "Actif"
              evaluation.state = "favorable"
              evaluation.reason = "company_opened"
              evaluation.score = 100
            else
              evaluation.state = "unfavorable"
              evaluation.reason = "company_closed"
              evaluation.score = 100
            end
          end
        end
      end
    end
  end
end
