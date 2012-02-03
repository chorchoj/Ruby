#pocet jedincov
$population_size=20
#pocet iteracii
$iterations=5000
#pocet mutacii a krizenia v jednej genracii
$cross_mut=10


#vec v batohu
class Item

  attr_accessor :weight, :cost, :h
  
  def initialize(w,c)
    
    @weight=w
    @cost=c
    @h=0

  end

  def to_s
    return "weight=#{@weight}, cost= #{@cost}"
  end
  

end






#jedinec pre GA
class Individual
  attr_accessor :chromozome,:fitness

  def initialize
    #chromozom-bitovy vektor -reprezentovany integerom
    @chromozome=0.to_i
    #fitness jedinca
    @fitness=0.to_f
  end

end



#definicia problemu batohu
class Solver


  
  def initialize
    @items=Array.new # pole veci
    @best_sol=0
  end






  def read_problem(filename)

    @in_file =filename
    
    begin
      file = File.new(@in_file, "r")
      #nacitaj riadok a rozdel na jednotlive casti
      line =file.gets.chomp!.split(" ")
      #sprav zo stringov integer
      line=line.each_index { |i| line[i]=line[i].to_i }

      
      #nacitaj id
      @id=line[0]
      #nacitaj pocet elementov
      @num_of_elements=line[1]
      #nacitaj kapacitu
      @capacity=line[2]

      puts "id:#{@id}, num of elements: #{@num_of_elements}, capacity:#{@capacity}"

      #kontrolna premenna- zistuje ci sa nacita cely pocet premmenych
      #nacitaj elementy
      idx=3
      while idx< line.size-1
        i=Item.new(line[idx],line[idx+1])
#        puts"item: "+i.to_s
        
        @items.push(i)
        idx=idx+2
      end

     
      file.close
    rescue => err
      puts "Exception: #{err}"
      err


    end

  end




 #inicializacia populacie
  def gen_init()

    @population=Array.new
   
    all_permut=2**@num_of_elements
#    puts "all permut : #{all_permut}"

    for i in 1..$population_size
      ind=Individual.new
      ind.chromozome=(@prng.rand(1...all_permut))
      ind.fitness=gen_fitness(ind.chromozome)
      @population.push(ind)
    end

  end





  #pocitanie fitness pre jedinca
  def gen_fitness(chromozome)
    w=0
    c=0
    pointer=1.to_i

    for j in 0...@num_of_elements
      if(pointer & chromozome >0) #posmienka!!!!!!!!1 >0
        w=w+@items[j].weight
        c=c+@items[j].cost
      end
      pointer=pointer<<1

    end

    if(c>@capacity)
      c=c/2
    end

    if(c>@best_sol)
      @best_sol=c
    end

    return c
  end







  #krizenie jedincov
  def gen_crossover()

    pointer=1.to_i
    tmp=0.to_i
    tmp2=0.to_i
    prng=Random.new

    pos=@prng.rand(1...@num_of_elements)#vmiesto krizenia chromozomu

    ind1=1#prvy jedinec
    ind2=1#druhy jedinec

    while ind1 == ind2
      ind1=@prng.rand($population_size)
      ind2=@prng.rand($population_size)
    end

    for i in 0...pos
      if(@population[ind1].chromozome & pointer >0 )
        tmp=tmp|pointer
      end

      if(@population[ind2].chromozome & pointer > 0)
        tmp2=tmp2|pointer
      end
      pointer=pointer<<1
    end#for


    for i in pos...@num_of_elements
      if(@population[ind1].chromozome & pointer >0)
        tmp2=tmp2|pointer
      end

      if(@population[ind2].chromozome & pointer >0)
        tmp=tmp|pointer
      end

    end


    nind=Individual.new
    nind.chromozome=tmp
    nind.fitness=gen_fitness(nind.chromozome)
    @population.push(nind)


    nind=Individual.new
    nind.chromozome=tmp2
    nind.fitness=gen_fitness(nind.chromozome)
    @population.push(nind)

  end#grossover





  #mutacia jedinca
  def gen_mutate()

    pos=@prng.rand(0...@population.size)#ktory jedinec bude mutovat
    tmp=@prng.rand(0...@num_of_elements) #ktory bit bude mutovat

    if @population[pos].chromozome & tmp >0

      ind=Individual.new
      ind.chromozome=@population[pos].chromozome & (~tmp)
      ind.fitness=gen_fitness(ind.chromozome)
      @population.push(ind)
   
    else

      ind=Individual.new
      ind.chromozome=@population[pos].chromozome | (~tmp)
      ind.fitness=gen_fitness(ind.chromozome)
      @population.push(ind)

    end
    
  end





  #soer populacie podla fitness
  def sort_population

    @population.sort! { |a,b| a.fitness <=> b.fitness }

  end





 #selekcia
  def gen_selection()

    population_rank=Array.new # pole  pre vyber populacie pomocou rank selection

    @new_population=Array.new
    #roztried populaciu
    sort_population
#    puts "$population_size : #{$population_size}"
    #
    #
    #rank selection
#    for i in 0...$population_size
##      ($population_size...i).each {  population_rank.push(i)  }  # tu je chyba
#      for j in i...$population_size #zmenit!
#        population_rank.push(i)
#
#      end
#
#
#    end

    for i in 0...$population_size
#      ($population_size...i).each {  population_rank.push(i)  }  # tu je chyba
      for j in 0..i #zmenit!
        population_rank.push(i)
      
      end


    end



    #vytvor novu populaciu -rank selection
    for k in 0...$population_size
      rnd=@prng.rand(0...population_rank.size)
      @new_population.push(@population[population_rank[rnd]])
    end

#    @population.clear

    @population.replace(@new_population)
#    @population=new_population
#@population=Marshal.load(Marshal.dump(@new_population))

  end#selection





  def genetic
   @prng=Random.new
   @best_sol=0
   
    #inicializuj populaciu

    gen_init


    for i in 0...$iterations

      gen_selection

      #opakuj mutaciu ak rizenie 
      for j in 1..$cross_mut
        #krizenie
        gen_crossover
        #mutacia
        gen_mutate

      end


    end


    @population.clear

    puts "Genetic result: #{@best_sol}"
    return @best_sol
  end



   #algoritmus dynamickeho programovania
  def dynamic
    #vytvorenie 2D pola na dynamicke programovanie
    # Array.new(width).map!{ Array.new(height) }
   
    width=@capacity+1 #we
    height=@num_of_elements+1 #n

    table=Array.new(width).map!{ Array.new(height) }


    for i in 0...width#vnuluj 1.stlpec
          table[i][0]=0
    end
  


  

   for i in 0...height#vynuluj 1.riadok
      table[0][i]=0
   end
  


    for w in 1...width
      for i in 1...height
        if (@items[i-1].weight <= w)
          if(@items[i-1].cost+table[w-@items[i-1].weight][i-1] > table[w][i-1])
            table[w][i]=@items[i-1].cost + table[w-@items[i-1].weight][i-1]
          else
            table[w][i]=table[w][i-1]
          end

        else
          table[w][i]=table[w][i-1]
        end#if

      end #for
    end#for


#    for i in 0...height
#      print "#{table[width-1][i]}  "
#    end

    
    result=table[width-1][height-1]
     puts "result of Dynamic programming: #{result}"
     table.clear
    return result
  end



  #heuristicke riesenie
  def heuristic

    result=0
    total_weight=0
    
    @items.each_index{|x| @items[x].h=(@items[x].cost/@items[x].weight) }

    @items.sort! { |a,b| a.h <=>b.h  }



    (@items.size-1).downto(0) do |i|
    
      if total_weight + @items[i].weight<= @capacity
        total_weight=total_weight + @items[i].weight
        result=result+@items[i].cost
      end
    
    end




    

    puts "result of Heuristic solver: #{result}"

    return result
  end





end

##
#p=Solver.new
#p.read_problem("../test/input5")
###p.dynamic
##p.genetic
#p.heuristic
