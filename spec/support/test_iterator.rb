class TestIterator

  def initialize arr
    @arr = arr.clone
  end

  def call
    @arr.delete(@arr.first)
  end

end
