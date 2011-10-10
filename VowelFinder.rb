# To change this template, choose Tools | Templates
# and open the template in the editor.



module Summable




  def sum(initial=0)
#      each  do |item|

       
        @text.scan(/[aeiouAEIOUYy]/)   do |item|

         print item
#        yield item
        end
        print"\n"
  end


end




class VowelFinder
  include Enumerable
  include Summable

  attr_accessor :text

  def initialize(text)
    @text = text

  end



  def each
      @text.scan(/[aeiouAEIOUYy]/) do |item|
      print item
      #yield item  vrati hodnotu
      end
  end

end #class

vfinder= VowelFinder.new("the quick brown fox jumped")


vfinder.sum


puts vfinder.inject(:+)
