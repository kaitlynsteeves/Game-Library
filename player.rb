#Line 50 reference: https://stackoverflow.com/questions/8206523/how-to-create-a-deep-copy-of-an-object-in-ruby

class Player

  @name
  @bag
  @throws
  @cup

  def initialize(name)
    @name = name
    @bag = Bag.new
    @cup = Cup.new
    @throws = Array.new
  end

  def name # returns the name of the player (does not set)
    @name
  end

  def store(item) # stores the item in the player's bag
    @bag.store(item)
  end

  def move_all(rc) # gets each item in rc and stores in the player's bag
    list = rc.get_contents

    (0...list.length).each {
      item = list.pop
      store(item)
    }
  end

  def load(description) # loads items from the player's bag to the player's cup based on the description

    if description == {}
      hand = @bag.empty
    else
      hand = @bag.select(description, :all)
    end

    @cup.move_all(hand)
  end

  def throw # throws the previously loaded cup, and replaces the items in the cup to the bag

    the_throw = @cup.throw.clone

    # the throw is both returned and stored internally
    @throws.push((Marshal.load(Marshal.dump(the_throw)))) #referenced at beginning of file
    move_all(@cup)
    the_throw
  end

  def clear # clears all stored throws
    (0...@throws.length).each {
      @throws.pop
    }
  end

  def tally(description) # sets the description, and calls tally() on each stored throw
    values = Array.new

    @throws.each do |throw|
      throw.description(description)
      values.push(throw.tally)
    end

    #returns each of the values within an array
    values
  end

  def sum(description) # sets the description, and calls sum() on each stored throw
    values = Array.new

    @throws.each do |throw|
      throw.description(description)
      values.push(throw.sum)
    end

    #returns the combined values as an array
    values
  end

  def results(description, throw) # sets the description and returns the values as an array from the given Throw, where the last throw is
  # "throw = 0", the throw before is "throw = 1", etc
    index = @throws.length - throw - 1
    # if a throw is requested that doesn't exist (too far back in time and never occurred), return nil
    if @throws[index] == nil
      return nil
    end

    @throws[index].description(description)
    @throws[index].results
  end

end