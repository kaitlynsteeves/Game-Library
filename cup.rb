class Cup < RandomizerContainer
  def throw # each randomizer in the cup is rolled or flipped, virtual copies of all randomizers are stored in a
    # newly created throw object, Which is returned

    #fill an array with everything in cup
    temp = Array.new
    (0...@contents.length).each {
      temp.push(@contents.pop)
    }

    #randomize everything in the array
    (0...temp.length).each {
      item = temp.pop
      item.randomize
      self.store(item)
    }
    #create and return new throw object
    Throw.new(self .clone)
  end

  def load(hand:Hand) #enters each randomizer from a Hand (synonym of move_all())
    self.move_all(hand)
  end

  def empty #returns a hand object to be returned to the bag, leaves cup empty
    hand = Hand.new
    hand.move_all(self )
    hand
  end

end