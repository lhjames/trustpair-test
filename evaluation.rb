# Evaluation class has been moved to its own file for better readibility

class Evaluation
  attr_accessor :type, :value, :score, :state, :reason

  def initialize(type:, value:, score:, state:, reason:)
    @type = type
    @value = value
    @score = score
    @state = state
    @reason = reason
  end

  def to_s()
    "#{@type}, #{@value}, #{@score}, #{@state}, #{@reason}"
  end
end