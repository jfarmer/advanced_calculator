class EvaluationSimplifier
  def self.run(tree)
    if tree.operator? && tree.left.numeric? && tree.right.numeric?
      tree.class.new tree.operator.call(tree.left.value, tree.right.value)
    else
      tree
    end
  end
end
