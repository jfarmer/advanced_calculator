require_relative './arithmetic_tree'
require_relative './postfix_parser'


class RPNCalculator
  def evaluate(expr, bindings = {})
    PostfixParser.new(expr).ast.simplify(bindings).to_postfix
  end
end

input = ARGV[0]
 
bindings = ARGV[1..-1].inject({}) do |hash, arg|
  var, val = arg.split('=')
  hash.update var.to_sym => val.to_i
end

puts RPNCalculator.new.evaluate(input, bindings)
