class UnitSimplifier
  def self.operator
    nil
  end
 
  def self.unit
    case self.operator
    when :+
      0
    when :*
      1
    end
  end
 
  def self.run(tree)
    return tree unless tree.value == self.operator
 
    if tree.left.value == self.unit
      tree.right
    elsif tree.right.value == self.unit
      tree.left
    else
      tree
    end
  end
end

class AdditionSimplifier < UnitSimplifier
  def self.operator
    :+
  end
end
 
class MultiplicationSimplifier < UnitSimplifier
  def self.operator
    :*
  end
end
