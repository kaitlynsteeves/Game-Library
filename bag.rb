class Bag < RandomizerContainer #when store() or move_all() are invoked, Bag makes sure that all randomizers added to the bag are reset
  def select(description, amt)
  #selects items from Bag based on description and returns Hand object that is
  #holding the items up to the number entered into amount (if you want all items, supply symbol :all instead of number)

    hand = Hand.new
    counter = 0
    new_contents = Array.new

    # traverse through each item
    (0...@contents.length).each  {|i|
      if amt != :all && counter >= amt
        return hand
      end
      #if the description contains an item key
      if description.has_key?(:item)
        #die
        if @contents[i].instance_of?(Die) == true && description[:item] == :die
          #specified denomination
          if check_colour(@contents[i],description)
            if check_up(@contents[i],description)
              if check_sides(@contents[i],description)
                hand.store(@contents[i])
                counter += 1
              else
                new_contents.push(@contents[i])
              end
            else
              new_contents.push(@contents[i])
            end
          else
            new_contents.push(@contents[i])
          end
        elsif  @contents[i].instance_of?(Coin) == true && description[:item] == :coin
          #specified colour
          if check_denomination(@contents[i],description)
            if check_up(@contents[i],description)
              hand.store(@contents[i])
              counter += 1
            else
              new_contents.push(@contents[i])
            end
          else
            new_contents.push(@contents[i])
          end
        else
          new_contents.push(@contents[i])
        end
        #item is not specified
      else
        if check_denomination(@contents[i],description)
          if check_colour(@contents[i],description)
            if check_up(@contents[i],description)
              if check_sides(@contents[i],description)
                hand.store(@contents[i])
                counter += 1
              else
                new_contents.push(@contents[i])
              end
            else
              new_contents.push(@contents[i])
            end
          else
            new_contents.push(@contents[i])
          end
        else
          new_contents.push(@contents[i])
        end
      end
    }
    self.empty
    (0...new_contents.length).each {
      self.store(new_contents.pop)
    }

    hand
  end

  def empty #empties all items from the Bag into a Hand, which is returned
    hand = Hand.new
    hand.move_all(self )
    hand
  end

  def check_denomination(item,description)
    if description.has_key?(:denomination)
      if description[:denomination] == item.denomination
        return true
      end
      return false
    end
    true
  end

  def check_colour(item,description)
    if description.has_key?(:colour)
      if description[:colour] == item.colour
        return true
      end
      return false
    end
    true
  end

  def check_up(item,description)
    if description.has_key?(:up)
      if description[:up] == item.result
        return true
      end
      return false
    end
    true
  end

  def check_sides(item,description)
    if description.has_key?(:sides)
      if description[:sides] == item.sides
        return true
      end
      return false
    end
    true
  end
end