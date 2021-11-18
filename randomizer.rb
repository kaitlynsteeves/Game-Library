class Randomizer

  @value
  @num_randomizations
  @type

  def randomize #both randomizes and returns randomizer itself for method chaining
    raise Exception.new "randomize() must be overridden in an implementing subclass"
  end

  def result #returns the result of the randomization, or nil if never randomized
    @value
  end

  def randomize_count #returns the number of randomizations performed
    @num_randomizations
  end

  def reset #sets the result to nil and number of randomizations performed to 0
    @value = nil
    @num_randomizations = 0
  end

end