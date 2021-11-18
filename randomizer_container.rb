
class RandomizerContainer #abstract class used for polymorphism and to store common methods

  @contents

  def initialize
    @contents = Array.new
  end

  def store(randomizer_obj) #stores a randomizer in the container
    @contents.push(randomizer_obj)
  end

  def move_all(rc) #get each randomizer in rc and store in self
    list = rc.get_contents

    (0...list.length).each {
      store(list.pop)
    }
  end

  def empty #removes all members of the container
    (0...@contents.length).each {
      @contents.pop
    }
  end

  def get_contents
    @contents
  end
end