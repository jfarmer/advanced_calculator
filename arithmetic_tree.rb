require_relative './binary_expression_tree'

Dir[File.dirname(__FILE__) + '/simplifiers/*.rb'].each  do |file|
  require file
end

class ArithmeticTree < BinaryExpressionTree
  define_operators :+, :*, :/, :-

  def self.simplifiers
    [AdditionSimplifier, MultiplicationSimplifier, ZeroMultiplicationSimplifier, EvaluationSimplifier]
  end

  def initialize(value)
    if value.to_s =~ /\A-?\d+\Z/
      @value = value.to_i
    else
      @value = value.to_sym
    end
  end

  def simplify(bindings = {})
    if self.operator?
      self.left  = self.left.simplify(bindings)
      self.right = self.right.simplify(bindings)
 
      self.class.simplifiers.inject(self) do |tree, simplifier|
        simplifier.run(tree)
      end
    else
      BindingSimplifier.new(bindings).run(self)
    end
  end

  def numeric?
    self.value.to_s =~ /\A-?\d+\Z/
  end
end
