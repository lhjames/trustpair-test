# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'vat_evaluation')
require File.join(File.dirname(__FILE__), 'evaluation')

RSpec.describe VatEvaluation do

  describe '#update_vat_company_score' do
    subject! { described_class.new(evaluations).update_vat_company_score }

    context 'API is NOT reachable' do

      context 'when current score is equal or greater than 50' do
        let(:evaluations) { [Evaluation.new(type: 'SIREN', value: 'IE6388047V', score: 80, state: 'unconfirmed', reason: 'unable_to_reach_api')] }

        it 'should decrease the score of 1 point' do
          expect(evaluations.first.score).to eq(79)
        end
      end

      context 'when current score is lower than 50' do
        let(:evaluations) { [Evaluation.new(type: 'SIREN', value: 'IE6388047V', score: 30, state: 'unconfirmed', reason: 'unable_to_reach_api')] }

        it 'should decrease the score of 3 points' do
          expect(evaluations.first.score).to eq(27)
        end
      end
    end
  end
end
