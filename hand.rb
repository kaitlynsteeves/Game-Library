class Hand < RandomizerContainer
  def next # removes and returns the last object added, if none stored, return nil
    @contents.pop
  end

  def empty # returns nil (items dropped on ground) ie the pointers to the contained objects are lost (and the objects
    #will be garbage collected by the system)
    (0...@contents.length).each {
      @contents.pop
    }
    nil
  end

end