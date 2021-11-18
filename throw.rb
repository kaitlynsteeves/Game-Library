class Throw

  @contents
  @description

  def initialize(cup)
    list = cup.get_contents
    @contents = Array.new
    (0...list.length).each { |i|
      @contents.push(list[i]).clone
    }
  end

  def description(description) # stores a description in the Throw from which the randomizer objects in the Throw
  # can be selected when computing the results, tally or sum
    if description == {}
      @description = nil
    else
      @description = description
    end
  end

  def results # returns an array containing the side up values or the randomizers recorded in the Throw.
  # Only include the values from randomizers that match the description stored in the Throw
    array = Array.new

    # if description() has not yet been called, return results from all randomizers
    if @description == nil
      @contents.each do |item|
        array.push(item.result)
      end
      return array
    end

    # traverse through each item
    @contents.each do |item|
      #if the description contains an item key
      if @description.has_key?(:item)
        #die
        if item.instance_of?(Die) == true && @description[:item] == :die
          #specified denomination
          if check_colour(item)
            if check_up(item)
              if check_sides(item)
                array.push(item.result)
              end
            end
          end
        elsif  item.instance_of?(Coin) == true && @description[:item] == :coin
          #specified colour
          if check_denomination(item)
            if check_up(item)
              array.push(item.result)
            end
          end
        end
      #item is not specified
      else
        if check_denomination(item)
          if check_colour(item)
            if check_up(item)
              if check_sides(item)
                array.push(item.result)
              end
            end
          end
        end
      end
    end
    array
  end

  def tally
  # counts the items in the Throw that match the description and returns the value
  # if description() has not yet been called, count all randomizers
    tally = 0

    # if description() has not yet been called, return results from all randomizers
    if @description == nil
      @contents.each do |item|
        tally += 1
      end
      return tally
    end

    # traverse through each item
    @contents.each do |item|
      #if the description contains an item key
      if @description.has_key?(:item)
        #die
        if item.instance_of?(Die) == true && @description[:item] == :die
          #specified denomination
          if check_colour(item)
            if check_up(item)
              if check_sides(item)
                tally += 1
              end
            end
          end
        elsif  item.instance_of?(Coin) == true && @description[:item] == :coin
          #specified colour
          if check_denomination(item)
            if check_up(item)
              tally += 1
            end
          end
        end
        #item is not specified
      else
        if check_denomination(item)
          if check_colour(item)
            if check_up(item)
              if check_sides(item)
                tally += 1
              end
            end
          end
        end
      end
    end
  tally
  end

  def sum
  # totals the value of the randomizer items in the Throw that match the description, where the value equals the
  # number that is "up" (for coins, :H = 1 and :T = 0), and returns the value
  # If description() has not been called, total the values across all randomizers

    sum = 0

    # if description() has not yet been called, return results from all randomizers
    if @description == nil
      @contents.each do |item|
        if item.result == :H
          sum += 1
        elsif item.result == :T
          sum += 0
        else
          sum += item.result
        end
      end
      return sum
    end

    # traverse through each item
    @contents.each do |item|
      #if the description contains an item key
      if @description.has_key?(:item)
        #die
        if item.instance_of?(Die) == true && @description[:item] == :die
          #specified denomination
          if check_colour(item)
            if check_up(item)
              if check_sides(item)
                sum += item.result
              end
            end
          end
        elsif  item.instance_of?(Coin) == true && @description[:item] == :coin
          #specified colour
          if check_denomination(item)
            if check_up(item)
              if item.result == :H
                sum += 1
              elsif item.result == :T
                sum += 0
              end
            end
          end
        end
        #item is not specified
      else
        if check_denomination(item)
          if check_colour(item)
            if check_up(item)
              if check_sides(item)
                if item.result == :H
                  sum += 1
                elsif item.result == :T
                  sum += 0
                else
                  sum += item.result
                end
              end
            end
          end
        end
      end
    end
    sum
  end

  def check_denomination(item)
    if @description.has_key?(:denomination)
      if @description[:denomination] == item.denomination
        return true
      end
      return false
    end
    true
  end

  def check_colour(item)
    if @description.has_key?(:colour)
      if @description[:colour] == item.colour
        return true
      end
      return false
    end
    true
  end

  def check_up(item)
    if @description.has_key?(:up)
      if @description[:up] == item.result
        return true
      end
      return false
    end
    true
  end

  def check_sides(item)
    if @description.has_key?(:sides)
      if @description[:sides] == item.sides
        return true
      end
      return false
    end
    true
  end
end