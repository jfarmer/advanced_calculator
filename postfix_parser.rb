class InvalidTokenError < StandardError;end

class PostfixParser
  def initialize(input)
    @input = input
  end
 
  def tokens
    @tokens ||= @input.split(' ')
  end

  def ast
    tokens.inject([]) do |stack, token|
      tree = ArithmeticTree.new(token)
 
      if tree.operator?
        tree.right = stack.pop
        tree.left  = stack.pop
 
        stack.push tree
      else
        stack.push tree
      end
    end.pop
  end
end
