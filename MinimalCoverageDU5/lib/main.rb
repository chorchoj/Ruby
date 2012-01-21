require_relative 'input_valid.rb'

class Segment
  attr_accessor :l,:r
  def initialize(l,r)
    @l=l
    @r=r
  end

#
#  def to_s
##    puts "#{@l}  #{@r}"
## puts @l
## puts @r
#  end

end

#class Array
#
#  def to_s
#    self.each { |item| print item  }
#  end
#
#
#end


class Solver
 # include InputValid
  attr_accessor :M, :segments, :solution

  def initialize(m,segments)
    @segments=segments
    @M=m
    # vysledok = pole indexov
    @solution=Array.new
    @sol_string=""

  end


  #usporiada jednotlive segmenty podla zlozki L (tzn "zaciatku"),
  # vybera najdlhsie segmenty tak aby pokryli pozadovany usek
  def solve

  #   puts"------solve---------"

    #usporaidaj segmenty
    @segments.sort! { |a,b| a.l <=> b.l  }

#   puts "segments size #{@segments.size}"
    #index odkial zacinam
 #   startidx=1
 
    #startovacia lava strana
    left=0
    right=0
    

    #inicializacia algoritmu - vezmi prvy prvok aby si mal s cim porovnavat
    #cyklus ktori prejde

    if @segments.size >0



        left=0 # obsadzujem od 0 dalej
        right=@segments[0].r
        sol=0



    #    for i in 0..(@segments.size-1)

          @segments.each_index  do |i|

       #

    #      if(@segments[sol].r >= @M) # ????????????
    #        if @solution.find_index(sol)==nil
    #          puts "pridavam riesenie 1"
    #           @solution.push(sol)
    #        end
    #
    #        break
    #      end

          # zaciatok na spravnom mieste ?-mensitko kvoli prvemu pruchodu !!!
          if( @segments[i].l <= left)
            # ak segment pokryva rovnaku cast ako predchodca ale siaha dalej tak to bude riesenie
            if @segments[i].r > right
              sol=i
              right=@segments[i].r
            end
          else # nepokryva z lavej strany dostatok
            @solution.push(sol)
            sol=i
            left=right
          end # if
      #    @solution.push(i)




      if(@segments[sol].r >= @M) # ????????????
            if @solution.find_index(sol)==nil
       #       puts "pridavam riesenie 1"
               @solution.push(sol)
            end

            break
          end


     end # each_index
      pom=0
     #zistit ci je to naozaj riesenie 
      #ak je riesenie dostatocne dlhe
      if (@segments[@solution[@solution.size-1]].r < @M)
        @solution.clear # nesplna podmienky riesenia
  #      break
        pom=1
      end
        ## skontroluj ci je riesenie dobe- je spojite
        
       # @solution.each_index do |index|
          for i in 1.. @solution.size-1
            if @segments[@solution[i]].l > @segments[@solution[i-1]].r
              pom=1
              break
            end
          end
  #        end
          if pom==1
            @solution.clear
          end


 end #if
  end # solve



  def print_solution
 
 #   puts "------solution-------"
  #  puts "solution size :  #{@solution.size}"
   # puts @solution.size
string_sol=(@solution.size).to_s 

string_sol=string_sol+"\n"
 #   puts "segment size:  #{@segments.size}"
#   @solution.each_index { |i| string_sol=string_sol+ "#{@segments[@solution[i]].l}  #{@segments[@solution[i]].r} "}
    @solution.each_index { |i| string_sol=string_sol+ (@segments[@solution[i]].l).to_s+" "+  @segments[@solution[i]].r.to_s+ "\n"}

 #   puts "0" if (@solution.empty?)

#    puts " "
    

#     print "pr"+string_sol

  return string_sol
  end

end


class MinCover


  def initialize
    segments = Array.new
    @problemCount=0
    @sol_string=""
  end


  def read_and_solve
    @problemCount = InputValid.read_int #gets.chomp!().to_i # nahraj pocet zadani
  #  puts "problemCount: #{@problemCount}"
    @sol_string=""


    for i in 1..@problemCount ## nahraj jednotlive zadania

      # nahraj zadanie
      segments=Array.new

      m= InputValid.read_int #gets.chomp!()
    #  puts "m: #{m}"
      segCount=0
      
      #nacitaj jednotlive segmenty
      begin
        pom= InputValid.read_int#gets.chomp!()

      #  pom.split(' ')
        l=pom[0].to_i
        r=pom[1].to_i
     #   puts " l=#{l} , r=#{r}"

        #ak som dostal ukoncovaci znak
        if (l==r and l==0)
 #         puts "dostal som ukoncovaci znak l=#{l} , r=#{r}"
          break
        end

        #ukladaj len tie ktore maju zmysel- nesmu koncit pred 0
        if r.to_i > 0 and l.to_i < m
          s= Segment.new(l.to_i, r.to_i)
       #   puts s
          segments[segCount]=s
          segCount=segCount+1
        end


      end while true
  #    puts "read_solve segments : #{segments}"
      # vyries jedno zadanie
      solver=Solver.new(m,segments)
      solver.solve
      @sol_string=@sol_string+ solver.print_solution+"\n"
    
      segments.clear
  
    end #for

    print @sol_string
    return @sol_string
  end #




  def read_and_solve_from_file(filename)

    
      @file =filename
      @sol_string=""

begin
      file = File.new(@file, "r")
      @problemCount =file.gets.chomp!.to_i
  #    puts "problemCount: #{@problemCount}"
#
#      while (line = file.gets.chomp!)
#
#
#
#      end

 for i in 1..@problemCount ## nahraj jednotlive zadania
 
      # nahraj zadanie
      segments=Array.new
      m=0
      while m==0 do
        m= file.gets.chomp!.to_i
      end
  #    puts "m: #{m}"
      segCount=0

      #nacitaj jednotlive segmenty
      begin
        pom= file.gets
      #  puts "pom : #{pom}"
        pom=pom.split(" ")
        l=pom[0].to_i
        r=pom[1].to_i
   #     puts " l=#{l} , r=#{r}"

        #ak som dostal ukoncovaci znak
        if (l==r and l==0)
 #         puts "dostal som ukoncovaci znak l=#{l} , r=#{r}"
          break
        end

        #ukladaj len tie ktore maju zmysel- nesmu koncit pred 0
        if r.to_i > 0 and l.to_i < m
          s= Segment.new(l.to_i, r.to_i)
       #   puts s
          segments[segCount]=s
          segCount=segCount+1
        end


      end while true
  #    puts "read_solve segments : #{segments}"
      # vyries jedno zadanie
     solver=Solver.new(m,segments)
      solver.solve
      @sol_string= @sol_string+solver.print_solution+"\n"
      segments.clear

    end #for
    print @sol_string

      file.close
rescue => err
      puts "Exception: #{err}"
      err


end



  return @sol_string
  end


end



p=MinCover.new

p.read_and_solve_from_file("../test/input8")