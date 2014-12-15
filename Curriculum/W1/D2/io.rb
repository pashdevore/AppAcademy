class InputOutput
  def guessing_game
    number = (1..100).to_a.sample
    count = 0

    win = false
    until win
      count += 1
      puts "What number did the computer pick?"
      user_guess = gets.chomp.to_i
      case user_guess <=> number
      when -1
        puts "Too low"
      when 0
        win = true
      when 1
        puts "Too high"
      end
    end

    puts "It took you #{count} times to win."
  end
end
