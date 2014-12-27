class Fixnum

  ONES = { 1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four',
           5 => 'five', 6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine' }

  TEENS = { 10 => 'ten', 11 => 'eleven', 12 => 'twelve', 13 => 'thirteen',
           14 => 'fourteen', 15 => 'fifteen', 16 => 'sixteen',
           17 => 'seventeen', 18 => 'eighteen', 19 => 'nineteen' }

  TENS = { 20 => 'twenty', 30 => 'thirty', 40 => 'forty', 50 => 'fifty',
           60 => 'sixty', 70 => 'seventy', 80 => 'eighty', 90 => 'ninety' }

  # takes a number and converts it into word form
  def in_words
    num_in_words = ""
    ones, tens = "", ""
    number = self
    return "zero" if number == 0
    if number % 100 > 9 && number % 100 < 20
      # we've hit a teen number
      tens = TEENS[number % 100]
      num_in_words.insert(0, tens)
    else
      ones = ONES[number % 10]
      number -= number % 10
      num_in_words.insert(0, ones) if !ones.nil?

      if number % 100 > 0
        tens = TENS[number % 100]
        number -= number % 100
        num_in_words.insert(0, tens + " ")
      end
    end

    if (number%1000) >= 100 && (number%1000) < 1000
      hundreds = ONES[(number % 1000)/100] + " hundred"
      number -= number % 1000
      num_in_words.insert(0, hundreds + " ")
    end

    greater_than_num = ""
    if number >= 1000000000000
      trillions = (number / 1000000000000).in_words + " trillion"
      number -= (number / 1000000000000) * 1000000000000
      greater_than_num << trillions + " "
    end
    if number >= 1000000000
      billions = (number / 1000000000).in_words + " billion"
      number -= (number / 1000000000) * 1000000000
      greater_than_num << billions + " "
    end
    if number >= 1000000
      millions = (number / 1000000).in_words + " million"
      number -= (number / 1000000) * 1000000
      greater_than_num << millions + " "
    end
    if number >= 1000
      thousands = (number / 1000).in_words + " thousand"
      number = 0
      greater_than_num << thousands + " "
    end
    (greater_than_num + num_in_words).strip
  end
end
