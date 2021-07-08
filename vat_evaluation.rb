require 'json'
require 'net/http'

class VatEvaluation
  def initialize(evaluations)
    @evaluations = evaluations
  end

  def fake_api
    data = [
      { state: 'favorable', reason: 'company_opened' },
      { state: 'unfavorable', reason: 'company_closed' },
      { state: 'unconfirmed', reason: 'unable_to_reach_api' },
      { state: 'unconfirmed', reason: 'ongoing_database_update' },
    ].sample
    evaluation.state = data[:state]
    evaluation.reason = data[:reason]
    evaluation.score = 100
  end

  def update_vat_company_score
  end
end