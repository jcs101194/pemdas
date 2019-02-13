#!/usr/bin/ruby

#~~~~~~~~~~~~~~~~~~~~~~~~~~~Classes~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class String

  @integer = false
  @operator = false

  def is_i
    if self =~ /\d/
      @integer = true
    end
  end

  def is_operator
    if self == '+' or self == '-' or self == '*' or self == '/'
      @operator = true
    end
  end

  def interpret_single_digit

    #Precondition: desired_character must be one letter long

    case self
      when '0'
        digit = 0
      when '1'
        digit = 1
      when '2'
        digit = 2
      when '3'
        digit = 3
      when '4'
        digit = 4
      when '5'
        digit = 5
      when '6'
        digit = 6
      when '7'
        digit = 7
      when '8'
        digit = 8
      when '9'
        digit = 9
      else
        digit = -1
    end
    digit
  end

end

class NilClass
  def is_i
    puts 'Uncaught error: string is uninitialized'
  end
  def is_operator
    puts 'Uncaught error: string is uninitialized'
  end

end

class Stack

  @index
  @top
  @stack_array
  @empty

  def constructor
    @index = 0
    @top = 100
    @stack_array = Array(100)
    @empty = false

  end

  def push(desired_character)

    if @index < 101
      @stack_array[@index] = desired_character
      @index = @index + 1
    end

  end

  def pop

    utility_variable = ''
    if @index > -1
      @index = @index - 1
      utility_variable = @stack_array[@index]
      @stack_array[@index] = nil
    elsif
      puts 'Error: Stack is empty'
    end

    utility_variable
  end

  def top

    @stack_array[@index]

  end

  def is_empty
    if @index == 0
      @empty = true
    else
      @empty = false
    end
    @empty
  end

end


class MathSolver

@math_expression = ''


  def tokenize(desired_string, desired_array)

    #Precondition: string type is passed
    #Postcondition: the method returns an array of strings

    i = 0
    array_index = 0
    current_token = ''

    until i >= desired_string.length

      current_character = desired_string[i]
      first_if_not_called = true

      if current_character.is_i

        current_token = ''
        first_if_not_called = false
        until current_character.is_operator
          current_token << current_character
          i=i+1
          current_character = desired_string[i]
          if current_character == nil
            break
          end
        end

      end

      if (current_character == '+' || current_character == '-' || current_character == '*' || current_character == '/') && first_if_not_called

        current_token = current_character

      end

      desired_array[array_index] = current_token
      array_index = array_index + 1
      current_token = ''
      if first_if_not_called
        i = i + 1
      end
      first_if_not_called = true

    end

    #This next line has no other significance other than to stop the debugger
    first_if_not_called = true

  end

  def current_have_lower(current_operator, previous_operator)

    #Postcondition: Return the operator with lower precedence. If
    #both operators have same precedence, then return nil

    pemdas = {'*' => 1, '/' => 1, '+' => 2, '-' => 2, '' => 3}
    operand_one = pemdas[current_operator]
    operand_two = pemdas[previous_operator]

    if operand_one < operand_two
      bool_variable = false
    elsif operand_one > operand_two
      bool_variable = true
    else
      bool_variable = nil
    end
    bool_variable
  end

  def string_getter(desired_string)
    @math_expression = desired_string
  end

  def solve_expression

    #Precondition: math_expression in infix
    #Postcondition: math_expression is reduced to an acceptable answer

    if 'derivative' == @math_expression['derivative']


    elsif 'integral' == @math_expression['integral']

    else
      evaluate_algebra
    end

  end

  def evaluate_algebra

    my_operator_stack = Stack.new
    my_operator_stack.constructor
    my_postfix = Array(100)
    previous_operator = ''
    token_array = Array(@math_expression.length)
    tokenize(@math_expression, token_array)

    i=0
    j=0
    until i > token_array.length

      current_token = token_array[i]
      if current_token.is_i

        my_postfix[j] = current_token
        j=j+1

      end
      if current_token.is_operator

        if current_have_lower(current_token, previous_operator)
          my_postfix[j] = my_operator_stack.pop
        else
          my_operator_stack.push(current_token)
        end

      end

      i=i+1
    end

    #Dump contents of operator stack until empty

    until my_operator_stack.is_empty
      my_postfix[j] = my_operator_stack.pop
      j=j+1
    end

    #Evaluate postfix
    j=0
    utility_variable = 0
    nil_array = Array[nil]
    until my_postfix.length == 1
      if my_postfix[j].is_operator
        if_structure_called = true
        if my_postfix[j] == '*'
          utility_variable = my_postfix[j-1].to_i * my_postfix[j-2].to_i
        elsif my_postfix[j] == '/'
          utility_variable = my_postfix[j-1].to_i / my_postfix[j-2].to_i
        elsif my_postfix[j] == '+'
          utility_variable = my_postfix[j-1].to_i + my_postfix[j-2].to_i
        elsif my_postfix[j] == '-'
          utility_variable = my_postfix[j-1].to_i - my_postfix[j-2].to_i
        end

        if if_structure_called
          my_postfix[j] = nil
          my_postfix[j-1] = nil
          my_postfix[j-2] = nil
          my_postfix[j-2] = utility_variable.to_s
          my_postfix = my_postfix - nil_array

          #The next line will adjust the index because the array is being modified
          j=j-2
        end
      end
      utility_variable = 0
      if_structure_called = false
      j=j+1
    end
    @math_expression = my_postfix.to_s
  end

  def differentiate

  end

  def integrate

  end

end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~main()~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

test_flag = true

if !test_flag
  puts 'Please enter an expression:'
  my_string = gets.to_s
else
  my_string = '2+2*8'
end

my_expression = MathSolver.new
my_expression.string_getter(my_string)
my_expression.solve_expression
