require 'rubygems'
require 'benchmark'
require 'mixico'

module Recipe
  def eggs(num=nil)
    num ? @eggs = num : @eggs
  end

  def vinegar(num=nil)
    num ? @vinegar = num : @vinegar
  end
end

def recipe(&block)
  mix_eval(Recipe, &block)
end
class MyRecipes
  r = 0
  puts  Benchmark.measure { 10000.times {
  r = recipe do
        eggs 99
        vinegar 8
      end
    }
  }

  p r

end





