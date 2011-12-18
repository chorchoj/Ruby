# To change this template, choose Tools | Templates
# and open the template in the editor.

#puts "Hello World"

class Point
  attr_reader :x, :y

  def initialize(x,y)
    @x=x.to_f
    @y=y.to_f

  end

  def to_s
    puts"{#{@x},#{@y}}"

  end
end

class Rectangle

  attr_accessor :x,:y,:a, :TL, :TR, :BL, :BR, :c

  def initialize(x,y,a)

    @c= Point.new(x,y)
    
    @a=a.to_f #dlzka strany stvorca

    #vypocitaj koordenaty vrcholov
    #Top left
    @TL=Point.new((@c.x-0.5*a), (@c.y+0.5*a))

    #Top right
    @TR= Point.new((@c.x+0.5*a),(@c.y+0.5*a))

    #Bottom Right
    @BR= Point.new((@c.x+0.5*a),(@c.y-0.5*a))

    #Bottom left
    @BL=Point.new((@c.x-0.5*a),(@c.y-0.5*a))



  end


 

  #obsah stvorca
  def area
    return a*a
  end

  def to_s
    puts"TL: #{@TL.to_s}, TR: #{@TR}, BL: #{@BL}, BR: #{@BR}"


  end


end

class Solver
  #viac moznosti  - mensi vo vnutri vacsieho, potombez prekrivu, maly prekriv


  def initialize(rectA, rectB)
    @rectA=rectA
    @rectB=rectB

  end




  #vracia obsah zjednotenia stvorcov
  def count_intersect
    #ako sa prekrivaju

    # projekcia na suradnice ? ?? ? ?? ? stale provnavat iba rohove body ?

    @intersectionX=0.0
    @intersectionY=0.0
    #pozicia podla x
    # rozdel horizontalne.
       
    # A presahuje za B zlava
    if @rectA.TR.x> @rectB.TL.x and @rectA.TL.x <@rectB.TR.x
      #   puts "@rectA.TR.x> @rectB.TL.x"
      @intersectionX=@rectA.TR.x.abs-@rectB.TL.x.abs
    end

    # 
    if @rectB.TR.x>@rectA.TL.x and @rectB.TL.x <@rectA.TR.x
      #    puts "@rectB.TR.x>@rectA.TL.x"
      @intersectionX=@rectB.TR.x.abs-@rectA.TL.x.abs
    end
     
    #vertikalne

    if @rectA.BR.y < @rectB.TR.y and @rectA.BR.y>@rectB.BR.y
      #  puts "@rectA.BR.y < @rectB.TR.y"
      @intersectionY=@rectB.TR.y.abs-@rectA.BR.y.abs
    end

    if @rectB.BR.y < @rectA.TR.y and @rectB.BR.y>@rectA.BR.y
      #    puts "ectB.BR.y < @rectA.TR.y"
      #   puts "@rectA.TR.y.abs-@rectB.BR.y.abs = #{@rectA.TR.y.abs} - #{ @rectB.BR.y.abs}"
      @intersectionY=@rectA.TR.y.abs-@rectB.BR.y.abs
    end


    if @rectA.c.x.to_f == @rectB.c.x.to_f and @rectA.c.y.to_f == @rectB.c.y.to_f
      #    puts"su v sebe vnorene "

      if(@rectA.a > @rectB.a)
        @intersectionX=@rectB.a
        @intersectionY=@intersectionX 
      else
        @intersectionX=@rectA.a
        @intersectionY=@intersectionX   
        
      end


    end
          
       
    #puts "intx : #{@intersectionX}"
    #puts "inty : #{@intersectionY}"
    #puts "area 1 #{@rectA.area}"
    #puts "area 2 #{@rectB.area}"

    if ((@intersectionX*@intersectionY) ==0)
      return 0.0

    end
    return ((@rectA.area+@rectB.area) - ( @intersectionX*@intersectionY).abs)



  end

  
  def solve

    a=count_intersect()
    a=a.to_f
    if a > 0 then
      puts"Obsah sjednoceni dvou ctvercu je #{a}"

    else
      puts "Ctverce se ani nedotykaji."

    end
  return a
  end
    

end


class Reader # trieda reader sluzi na validaciu vstupu

  def read_size(a) #velkost stvorca

    if ! is_num?(a) || a.to_f <= 0 then

      puts("Spatny vstup")
      return false
    end
     return true
  end


  def read_point(p) # zlozka suradnice vstupu
    if ! is_num?(p)  then
      puts("Spatny vstup")
      return false

    end
    #   return p.to_f
    return true
  end


  def is_num?(n) # ide o cislo ?

    #n.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true

    begin
      Float(n)
    rescue
      false # not numeric
    else
      true # numeric
    end

  end




end
#end
#nacitaj prvy stvorec
#r=Reader.new
#
#puts "Zadejte delku hrany prvniho ctverce:"
#a=gets.chomp
#if(r.read_size(a)== false)
#  abort
#end
#
#
#puts "Zadejte x-ovou souradnici stredu prvniho ctverce: "
#x=gets.chomp
#if(r.read_point(x)==false )
#  abort
#end
#
#
#puts "Zadejte y-ovou souradnici stredu prvniho ctverce: "
#y=gets.chomp
#if(r.read_point(y)==false)
#  abort
#end
#
#
#rectA=Rectangle.new(x.to_f,y.to_f,a.to_f)
#
##nacitaj druhy stvorec
#
#puts "Zadejte delku hrany druheho ctverce: "
#a=gets.chomp
#if(r.read_size(a)==false)
#  abort
#end
#
#
#puts "Zadejte x-ovou souradnici stredu druheho ctverce: "
#x=gets.chomp
#if(r.read_point(x)==false)
#  abort
#end
#puts "Zadejte y-ovou souradnici stredu druheho ctverce: "
#y=gets.chomp
#if(r.read_point(y)==false)
#  abort
#end
#
#rectB=Rectangle.new(x.to_f,y.to_f,a.to_f)
#
#
#
#s= Solver.new(rectA,rectB)
#s.solve()
