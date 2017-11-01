class Hands
  attr_accessor :hands, :count_hash

  def initialize(hands)
    @hands = hands
    @count_hash = Hash.new(0)

    @hands.each do |hand|
      @count_hash[hand[:num]] += 1
    end
  end

  def is_flash?
    flag = true
    @hands[1..4].each do |hand|
      flag = false if @hands[0][:suit] != hand[:suit]
    end
    flag
  end

  def is_straight?
    arr = []
    @hands.each do |hand|
      arr << hand[:num].to_i
    end
    arr.sort.each_cons(2).all? { |x,y| y == x + 1 }
  end

  def is_straight_flash?
    is_flash? && is_straight?
  end

  def is_four_card?
    true if @count_hash.values.max >= 4
  end

  def is_three_card?
    unless is_four_card?
      true if @count_hash.values.max >= 3
    end
  end

  def is_pair?
    unless is_three_card? or is_two_pair?
      true if @count_hash.values.max >= 2
    end
  end

  def is_full_house?
    if is_three_card?
       true if @count_hash.values.sort.reverse[1] >= 2 #カードが5枚同じの来る時error
     end
   end

   def is_two_pair?
    unless is_three_card?
      true if @count_hash.values.sort.reverse[0] == 2 && @count_hash.values.sort.reverse[1] == 2
    end
  end

end



p 'カードを入力してください 例:H1 H3 H3 H4 H5'
# input = gets
input = 'H2 H4 H5 H3 H1'
hands = []
input.split.each do |ele|
  hands << {"suit":ele[0], "num":ele[1]}
end

hand1 = Hands.new(hands)

p hand1.is_flash?
p hand1.is_four_card?
p hand1.is_full_house?
p hand1.is_two_pair?
p hand1.is_pair?
p hand1.is_straight?
p hand1.is_straight_flash?