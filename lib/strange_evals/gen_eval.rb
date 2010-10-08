require 'rubygems'
require 'benchmark'
require 'gen_eval'

class Recipe
  def eggs(num=nil)
    num ? @eggs = num : @eggs
  end

  def vinegar(num=nil)
    num ? @vinegar = num : @vinegar
  end
end

def recipe(&block)
  gen_eval(Recipe, &block)
end
class MyRecipes
  r = 0
  puts  Benchmark.measure { 10000.times {
      r = Recipe.new.gen_eval do
        eggs 99
        vinegar 8
      end
    }
  }

  p r

end





