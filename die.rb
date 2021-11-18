class Die < Randomizer

  @colour
  @sides

  def initialize(sides, colour)
    @sides = sides
    @colour = colour

    @value = nil
    @num_randomizations = 0
    @type = :die
  end

  def randomize
    @num_randomizations = @num_randomizations + 1
    roll
    self
  end

  def colour #returns the colour of the die
    @colour
  end

  def sides #returns the number of sides
    @sides
  end

  def roll #randomizes and returns the "rolled" die
    @value = rand(1..@sides)
    self
  end

  def sideup #returns 1..sides or nil
    @value
  end

end