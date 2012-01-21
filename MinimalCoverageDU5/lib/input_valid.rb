module InputValid


    def InputValid.numeric?(n)
       #n.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
#      puts"numeric? input > #{n}"
      begin
        Float(n)
        rescue
#          puts "not num"
          return false # not numeric
        else
#          puts"is num"
          return true # numeric

      end
      
    end

    # vrati true ak je vstup cislo, alebo aray cisel, inak false
    def InputValid.is_num?(n) # ide o cislo ?


     
    if n.size == 0
#      puts "n size = #{n.size} vraciam false"
     return false
    end
     # n=n.to_a
      if (n.kind_of?(Array)==true)

         for i in 0..n.size-1
        
            if(InputValid.numeric?(n[i])==false)
#              puts "returning false"
              return false
            end
           
          end
#          puts "returning true"
        return true
      else
        return InputValid.numeric?(n)

      end




  end



  # cita vstup a vracia cislo na riadku(alebo pole cisel), ktory nieje prazdny, 
  def InputValid.read_int
      
   

    begin
       n=gets.chomp!()
     #  puts "n:#{n}"
       n= n.split(' ')
   
 
    end while (InputValid.is_num?(n)==false )


    return n[0].to_i if (n.size==1)

    n.each_index { |i| n[i]=n[i].to_i  }

#    puts "n:#{n}"
    return n
  end




end
