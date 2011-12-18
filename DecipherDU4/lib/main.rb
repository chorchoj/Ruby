# To change this template, choose Tools | Templates
# and open the template in the editor.


class Decipher

def initialize(cipherText, transposition)

  @ct=cipherText # sifrovany text
  @t=transposition # o kolko sa bude posuvat
end

#ascii table je od 0 - 127
#printable su od 32 -126, 32 - space (33 zacina znak)

def decipher
 
  # ot open text -desifrovany text
 ot=""
  @ct.each_byte { |b| x= (b+@t).modulo(126); ot.concat(x) }


  print ot

  return ot
  
end



  
end
#"1JKJ'pz'{ol'{yhklthyr'vm'{ol'Jvu{yvs'Kh{h'Jvywvyh{pvu5
#1PIT'pz'h'{yhklthyr'vm'{ol'Pu{lyuh{pvuhs'I|zpulzz'Thjopul'Jvywvyh{pvu5
#1KLJ'pz'{ol'{yhklthyr'vm'{ol'Kpnp{hs'Lx|pwtlu{'Jvywvyh{pvu5"

#puts"zadejte sifrovany text : "
#
#begin
#y=gets.chomp
#
##y.each_line{|s| d = Decipher.new(s,-7); d.decipher }
#d = Decipher.new(y,-7)
#d.decipher
#puts "\n"
#end while y!=nil