class RockPaperScissors

  def rps(user_choice)
    computer_pick = ['rock', 'paper', 'scissors'].sample

    # user outcomes
    rock_outcomes = { 'rock' => 'draw', 'paper' => 'lose', 'scissors' => 'win' }
    paper_outcomes = { 'rock' => 'win', 'paper' => 'draw', 'scissors' => 'lose' }
    scissor_outcomes = { 'rock' => 'lose', 'paper' => 'win', 'scissors' => 'draw' }

    if user_choice.downcase == 'rock'
      "User: #{user_choice.capitalize}, Computer: #{computer_pick.capitalize}.\
       You #{rock_outcomes[computer_pick]}."
    elsif user_choice.downcase == 'paper'
      "User: #{user_choice.capitalize}, Computer: #{computer_pick.capitalize}.\
       You #{paper_outcomes[computer_pick]}."
    else
      "User: #{user_choice.capitalize}, Computer: #{computer_pick.capitalize}.\
       You #{scissor_outcomes[computer_pick]}."
    end
  end
end

class Mixology

  # bonus to make sure drinks aren't in original form

  def remix(drinks)
    alcohols, mixers = [], []
    drinks.each do |array|
      alcohols << array.first
      mixers << array.last
    end

    alcohols.shuffle!
    mixed_drinks = []
    (0...drinks.count).map do |index|
      mixed_drinks << [alcohols[index], mixers[index]]
    end

    mixed_drinks
  end
end
