# Write a function get_products_of_all_ints_except_at_index() that takes an array
# of integers and returns an array of the products.

class Naive
  def self.get_products_of_all_ints_except_at_index ints
    ints.each_with_index.map do |int, i|
      subints = ints.dup
      subints.delete_at i
      subints.reduce(&:*)
    end
  end
end

class Optimized
  def self.get_products_of_all_ints_except_at_index ints
    products = []
    product = 1
    
    ints.each_with_index do |int, i|
      products[i] = product
      product *= int
    end
    
    product = 1
    i = ints.size - 1
    while i > -1 do
      products[i] *= product
      product *= ints[i]
      i -= 1
    end
    
    products
  end
end

{
  [1, 7, 3, 4] => [84, 12, 28, 21],
  [1, 0, 3, 4] => [0, 12, 0, 0],
  [2, 4, 10] => [40, 20, 8],
}.each do |input, output|
  [Naive, Optimized].each do |klass|
    result = klass.get_products_of_all_ints_except_at_index input
    if result == output
      puts "pass"
    else
      puts "#{klass}: given #{input}, expected #{output} but got #{result}"
    end
  end
end
