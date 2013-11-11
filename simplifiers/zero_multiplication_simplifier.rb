class ZeroMultiplicationSimplifier
  def self.run(tree)
    return tree unless tree.value == :*
 
    if tree.left.value == 0 || tree.right.value == 0
      tree.class.new(0)
    else
      tree
    end
  end
end
