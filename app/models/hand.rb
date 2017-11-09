class Hand
  include ActiveModel::Model
  attr_accessor :hands, :count_hash, :string

  validates :string, format: { with: /\A[SHDC][1-9][0-3]?\s[SHDC][1-9][0-3]?\s[SHDC][1-9][0-3]?\s[SHDC][1-9][0-3]?\s[SHDC][1-9][0-3]?\z/, message: "文字列が指定したフォーマットではありません" }
  validate :cards_cannot_be_double

  def initialize(hands)
    @string     = hands
    @hands      = separate(hands)
    @count_hash = Hash.new(0)

    @hands.each do |hand|
      @count_hash[hand[:num]] += 1
    end
  end

  def separate(input)
    hands = []
    input.split.each do |ele|
      hands << { "suit": ele.slice!(0), "num": ele }
    end
    hands
  end

  def cards_cannot_be_double
    unless @hands === @hands.uniq
      errors.add(:hands, "カードは重複できません")
    end
  end

  def is_flash?
    @hands[1..4].each do |hand|
      return false if @hands[0][:suit] != hand[:suit]
    end
    true
  end

  def is_straight?
    arr = []
    @hands.each do |hand|
      arr << hand[:num].to_i
    end
    arr.sort!
    arr.each_cons(2).all? {|x, y| y == x + 1} || arr == [1, 10, 11, 12, 13]
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
      { "name": "ストレート・フラッシュ", "power": 8 }
    elsif is_four_card?
      { "name": "フォー・オブ・ア・カインド", "power": 7 }
    elsif is_full_house?
      { "name": "フルハウス", "power": 6 }
    elsif is_flash?
      { "name": "フラッシュ", "power": 5 }
    elsif is_straight?
      { "name": "ストレート", "power": 4 }
    elsif is_three_card?
      { "name": "スリー・オブ・ア・カインド", "power": 3 }
    elsif is_two_pair?
      { "name": "ツーペア", "power": 2 }
    elsif is_pair?
      { "name": "ワンペア", "power": 1 }
    else
      { "name": "ハイカード", "power": 0 }
    end
  end

  def is_stronger_than_or_eqaul(hand) # hand is an instance of this class
    check[:power] >= hand.check[:power]
  end
end




