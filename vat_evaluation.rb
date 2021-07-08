require 'json'
require 'net/http'

class VatEvaluation
  def initialize(evaluations)
    @evaluations = ::Evaluation.new
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
    fake_api
    @evaluations.each do |evaluation|
      case evaluation.type == 'VAT'
      when evaluation.score.positive? && evaluation.state == 'unconfirmed' && evaluation.reason == 'ongoing_database_update'
        evaluation.score - 1
      when evaluation.score >= 50 && evaluation.state == 'unconfirmed' && evaluation.reason == 'unable_to_reach_api'
        evaluation.score - 3
      end
    end
  end
end