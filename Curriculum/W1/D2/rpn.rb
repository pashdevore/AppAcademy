class ReversePolishNotation
	OPERANDS = %w(* / + -)
  
  def rpn
    user_input = ""
    stack = []
    
    if ARGV[0]
      #we're reading from a file
      
    end

      until user_input == "="
        user_input = gets.chomp

        if user_input[-1] == "t"
          puts "Inside txt file"
          return rpn_from_array(stack, execute_file(user_input))
        end

        if OPERANDS.include?(user_input)
          if stack.count < 2
            puts "Invalid entry"
            next
          end
          #we know that an operand has been added
          calculate(stack, user_input)
        elsif user_input == "="
          break
        else
          stack.push(user_input.to_i)
        end
      end

    stack.pop
  end

  def calculate(stack, user_input)
    number2 = stack.pop
    number1 = stack.pop
    stack.push(number1.send(user_input.to_sym, number2))
    stack
  end

  def execute_file(file_name)
    problem = File.readlines(file_name)
    problem.map!{ |l| l.chomp }
    problem
  end

  def rpn_from_array(stack, problem)
    problem.each do |el|
      if OPERANDS.include?(el)
        calculate(stack, el)
      else
        stack.push(el.to_i)
      end
    end
    stack.pop
  end
end

if $PROGRAM_NAME == __FILE__
  p ReversePolishNotation.new.rpn
end