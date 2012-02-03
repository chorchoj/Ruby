# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require_relative '../lib/main'

class KnapsackTest < Test::Unit::TestCase

  
  
  #testovanie vysledkov dynamickeho programovania pre vstup s 10 vecami
  def test_DP_10
  path="/home/miro/NetBeansProjects/Knapsack/test/"
  
  p=Solver.new
#  p.read_problem(path+"input1")
  p.read_problem(path+"input1")
  
  assert_equal(798, p.dynamic)

  p=Solver.new
  p.read_problem(path+"input2")

  assert_equal(1243, p.dynamic)



  end

   #testovanie vysledkov dynamickeho programovania pre vstup s 20 vecami
   def test_DP_20
  path="/home/miro/NetBeansProjects/Knapsack/test/"

  p=Solver.new

  p.read_problem(path+"input3")

  assert_equal(1995, p.dynamic)

  p=Solver.new
  p.read_problem(path+"input4")

  assert_equal(2168, p.dynamic)

  p=Solver.new
  p.read_problem(path+"input5")

  assert_equal(2623, p.dynamic)



  end



   # heuristicky solver
    def test_HEURISTIC_10
  path="/home/miro/NetBeansProjects/Knapsack/test/"

  p=Solver.new
#  p.read_problem(path+"input1")
  p.read_problem(path+"input1")

      assert_equal(752, p.heuristic)

  p=Solver.new
  p.read_problem(path+"input2")

      assert_equal(1243, p.heuristic)



  end


     #testovanie vysledkov  heuristiky pre vstup s 20 vecami
   def test_HEURISTIC_20
  path="/home/miro/NetBeansProjects/Knapsack/test/"

  p=Solver.new

  p.read_problem(path+"input3")

     assert_equal(1979, p.heuristic)

  p=Solver.new
  p.read_problem(path+"input4")

  assert_equal(2168, p.heuristic)

  p=Solver.new
  p.read_problem(path+"input5")

  assert_equal(2516, p.heuristic)



  end



end
