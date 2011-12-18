#$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
#require 'decipher'
require_relative '../lib/main'
class Decipher_test < Test::Unit::TestCase
  def test_decipher
    #TODO: Write test
    d = Decipher.new("1JKJ'pz'{ol'{yhklthyr'vm'{ol'Jvu{yvs'Kh{h'Jvywvyh{pvu51PIT'pz'h'{yhklthyr'vm'{ol'Pu{lyuh{pvuhs'I|zpulzz'Thjopul'Jvywvyh{pvu51KLJ'pz'{ol'{yhklthyr'vm'{ol'Kpnp{hs'Lx|pwtlu{'Jvywvyh{pvu5",-7)
   
    expected="*CDC is the trademark of the Control Data Corporation.*IBM is a trademark of the International Business Machine Corporation.*DEC is the trademark of the Digital Equipment Corporation."
    #flunk "TODO: Write test"

    assert_equal(expected, d.decipher)
  end
end
