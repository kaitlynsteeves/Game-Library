class Coin < Randomizer

  @denomination

  def initialize(denomination)
    @denomination = denomination
    @value = nil
    @num_randomizations = 0
    @type = :coin
    self
  end

  def randomize
    @num_randomizations = @num_randomizations + 1
    flip
    self
  end

  def denomination #returns the denomination of the coin
    @denomination
  end

  def flip #flips the coin and returns the flipped coin (for method chaining)

    temp = rand(1..2)
    if temp == 1
      @value = :H
    else
      @value = :T
    end

    self #return the flipped coin
  end

  def sideup #returns :H or :T (result of last flip) or nil if not flipped yet
    @value
  end

end