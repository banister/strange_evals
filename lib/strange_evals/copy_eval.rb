require 'benchmark'

module Recipe
  def eggs(num=nil)
    num ? @eggs = num : @eggs
  end

  def vinegar(num=nil)
    num ? @vinegar = num : @vinegar
  end
end

def recipe(&block)
  context = eval('self', block.binding)
  context_copy = context.dup
  context_copy.extend(Recipe)

  context_copy.instance_eval(&block)

  # update state in the original
  context_copy.instance_variables.each do |v|
    context.
      instance_variable_set(v, context_copy.instance_variable_get(v))
  end

  [context.instance_variable_get(:@eggs), context.instance_variable_get(:@vinegar)]
end

class MyRecipes
  def self.calc_eggs
    99
  end

  r=0
  puts  Benchmark.measure { 10000.times {
  @vinegar_count = 8
  r = recipe do
    eggs calc_eggs
    vinegar @vinegar_count
    end
    }
  }

  p r

  # check to see that eggs method is no longer mixed in
  eggs rescue puts "eggs method no longer exists (existed only in copy"
end





