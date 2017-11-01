class Hand
  attr_accessor :hands, :count_hash

  def initialize(hands)
    @str = hands
    @hands = separate(hands)
    @count_hash = Hash.new(0)

    @hands.each do |hand|
      @count_hash[hand[:num]] += 1
    end
  end

  def set(hands)
    @hands = @hands.initialize(separate(hands))
  end

  def to_string
    @str
  end

  def separate(input)
    hands = []
    input.split.each do |ele|
      hands << {"suit":ele.slice!(0), "num":ele}
    end
    hands
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
    arr.sort!
    arr.each_cons(2).all? { |x,y| y == x + 1 } || arr == [1,10,11,12,13]
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

  def check
    if is_straight_flash?
      {"name": "ストレート・フラッシュ", "power": 8}
    elsif is_four_card?
      {"name": "フォー・オブ・ア・カインド", "power": 7}
    elsif is_full_house?
      {"name": "フルハウス", "power": 6}
    elsif is_flash?
      {"name": "フラッシュ", "power": 5}
    elsif is_straight?
      {"name": "ストレート", "power": 4}
    elsif is_three_card?
      {"name": "スリー・オブ・ア・カインド", "power": 3}
    elsif is_two_pair?
      {"name": "ツーペア", "power": 2}
    elsif is_pair?
      {"name": "ワンペア", "power": 1}
    else
      {"name": "ハイカード", "power": 0}
    end
  end

  def is_stronger_than_or_eqaul(hand) #diffrent hand
    check[:power] >= hand.check[:power]
  end
end


# p 'カードを入力してください 例:H1 H3 H3 H4 H5'
# # input = gets
# input = 'H2 H4 H5 H3 H1'


# hand1 = Hands.new(hands)

