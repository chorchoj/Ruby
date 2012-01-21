
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require_relative '../lib/main'


class MinCovTest < Test::Unit::TestCase

  def test_min_1
   p=MinCover.new

    path="/home/miro/NetBeansProjects/MinimalCoverageDU5/test/"
    expected="0\n\n1\n0 1\n\n"

    assert_equal(expected, p.read_and_solve_from_file(path+"input1"))

    expected="3\n0 2\n2 4\n4 6\n\n"
    assert_equal(expected, p.read_and_solve_from_file(path+"input2"))
    expected="0\n\n"
    assert_equal(expected, p.read_and_solve_from_file(path+"input3"))

    expected="1\n0 1\n\n"
    assert_equal(expected, p.read_and_solve_from_file(path+"input4"))

    expected="4\n-1 6\n3 7\n7 8\n8 10\n\n"
    assert_equal(expected, p.read_and_solve_from_file(path+"input5"))

    expected="0\n\n"
    assert_equal(expected, p.read_and_solve_from_file(path+"input6"))

    expected="0\n\n"
    assert_equal(expected, p.read_and_solve_from_file(path+"input7"))

    expected="1\n0 10\n\n"
    assert_equal(expected, p.read_and_solve_from_file(path+"input8"))



    
  end


end
