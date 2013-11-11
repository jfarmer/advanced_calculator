class BinaryExpressionTree
  def self.define_operators(*ops)
    @operators ||= []
    @operators += ops.map(&:to_sym)

    ops.each do |op|
      define_method(op) do |tree|
        self.class.new(op).tap do |t|
          t.left  = self
          t.right = tree
        end
      end
    end
  end

  def self.operators
    @operators ||= []
  end

  def self.operator?(op)
    self.operators.include? op
  end

  attr_accessor :left, :right, :value

  def initialize(value)
    @value = value
  end

  def to_postfix
    if self.leaf?
      self.value.to_s
    else
      "#{self.left.to_postfix} #{self.right.to_postfix} #{self.value}"
    end
  end

  def leaf?
    self.left.nil? && self.right.nil?
  end

  def operator
    return unless operator?

    Proc.new do |a,b|
      a.send(self.value, b)
    end
  end

  def operator?
    self.class.operator? self.value.to_s.to_sym
  end
end
