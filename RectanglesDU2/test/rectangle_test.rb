# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'main'

class Rectangle_test < Test::Unit::TestCase
  def test_input #testuje vstup
    r=Reader.new()

    #test vstupu pre suradnicu

#    dobre zadany vstup

    #suradnice
    assert_equal(true,r.read_point("-2"))

    assert_equal(true,r.read_point("0"))

    assert_equal(true,r.read_point("2.0"))

    #velkost

    assert_equal(true,r.read_size("2.0"))

    assert_equal(true,r.read_size("4"))

    # zle zadany vstup

     #suradnice
     assert_equal(false,r.read_point("-a"))

     assert_equal(false,r.read_point("b"))

     assert_equal(false,r.read_point(""))


     #velkost
      assert_equal(false,r.read_size("0"))

      assert_equal(false,r.read_size("-1"))

      assert_equal(false,r.read_size("0"))


  end


  def test_solver # testuje spravne pocitanie solveru
   
    
    a=Rectangle.new(0,0.000e-3,4.0)
    b=Rectangle.new(-2,-2e0,2.0e+0)
    s=Solver.new(a,b)
    assert_equal(19,s.solve)


    a=Rectangle.new(-10e20,3e-2,5.23)
    b=Rectangle.new(+3e100, -1,4.345643225)
    s=Solver.new(a,b)
    assert_equal(0,s.solve)



  end
end
