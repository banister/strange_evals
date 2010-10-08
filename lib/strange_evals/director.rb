require 'benchmark'
class Director 
  def initialize(*receivers)
    @receivers = receivers
  end

  def run(&block)
    instance_eval(&block)
  end

  def method_missing(name, *args, &block)
    @receivers.each do |receiver|
      if receiver.respond_to?(name)
         return receiver.send(name, *args, &block)
      end
    end
    raise "no such method '#{name}' on receivers #{@receivers}"
  end
end

class Recipe
  def eggs(num=nil)
    num ? @eggs = num : @eggs
  end

  def vinegar(num=nil)
    num ? @vinegar = num : @vinegar
  end
end

def recipe(&block)
  r = Recipe.new
  context = eval('self', block.binding)
  d  = Director.new(r, context).run(&block)
  [r.eggs, r.vinegar]
end

class MyRecipes
  def self.calc_eggs
    99
  end
  r = 0
    puts  Benchmark.measure { 10000.times {

  r = recipe do
    eggs calc_eggs
      end
      }}
  p r
end





