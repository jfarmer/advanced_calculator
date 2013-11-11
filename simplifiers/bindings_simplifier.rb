class BindingSimplifier
  def initialize(bindings = {})
    @bindings = bindings
  end
 
  def run(tree)
    return tree if tree.operator? || tree.numeric?
 
    if @bindings.has_key? tree.value
      tree.class.new @bindings[tree.value]
    else
      tree
    end
  end
end
