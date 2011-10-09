


class Node
  #label - ne/navstiveny
  attr_accessor :visited, :childNodes

  def initialize

    # zoznam potomkov
  @childNodes= Array.new
  @visited=0
  
  end


  def unvisit!
    @visited=0

  end

  def is_visited?
    return @visited

  end


  def visit!
    @visited=1

  end

#  def to_s
#    puts"childs :"
#    puts"size: #{@childNodes.size}"
#    @childNodes.each_index do |i|
#      puts "#{@childNodes[i]}"
#
#    end



#  end


end





class Graph
attr_accessor :nodes
  #zasobnik
#
#
#pole uzlov
def initialize
  @nodes= Array.new
end


def restart_visit!

  @nodes.each_index do |index|
  @nodes[index].unvisit!
  end

end


  
  def DFS(startNode)
#    algoritmus DFS - pomocou stacku

#   puts "DFS"

    stack= Array.new # do stacku davam pozicie 
#    puts @nodes.size
#    puts "#{startNode} "

    stack.push(startNode)



    while not stack.empty?
#      puts stack.to_s
      n=stack.pop()
      
      if @nodes[n-1].is_visited? == 0
        @nodes[n-1].visit!
        print n.to_s+" "
      
        #      for i in 0.. @nodes[n-1].childNodes.size-1 do
        for i in  (@nodes[n-1].childNodes.size-1).downto(0)   do
                 x= @nodes[n-1].childNodes[i]
                  if @nodes[x-1].is_visited? == 0
        #            @nodes[x-1].visit!
                    stack.push(x)
                  end

              end
      end


    end

    print "\n"





  end


  def recursive_DFS(startNode)

    @nodes[startNode-1].visit!
#    puts "uzol:#{startNode}"

      for i in 0.. @nodes[startNode-1].childNodes.size-1 do
    
      n= @nodes[startNode-1].childNodes[i]
      if @nodes[n-1].is_visited? == 0 
        recursive_DFS(n-1)
  
       end


     end

  end

  def BFS(startNode)
#    puts "BFS"
    
#    puts "#{startNode} "
    queue= Array.new
    queue.unshift(startNode)
#    @nodes[startNode-1].visit!
    while not queue.empty?
      n=queue.pop()
      print n.to_s+" "
      @nodes[n-1].visit!
      for i in 0.. @nodes[n-1].childNodes.size-1 do
#for i in  (@nodes[n-1].childNodes.size-1).downto(0)   do
        x= @nodes[n-1].childNodes[i]
        if @nodes[x-1].is_visited? == 0
          @nodes[x-1].visit!
          queue.unshift(x)
        end
      end


    end


 print "\n"

  end








  def to_s
    @nodes.each_index  do |i|
      puts"uzol: #{i}"
      puts @nodes[i].to_s



    end


  end

end

class Solver


  def do_work
    file = File.new("input.txt", "r")
 
      @input =file.readlines #mam pole riadkov
      
      file.close

    @graph_count=@input[0].to_i #pocet grafov
#    puts @graph_count.to_s

      pos=0 # na ktorom riadku v subore som

    for i in 0..@graph_count-1 #vytvaraj jednotlive grafy
      pos=pos+1
      node_count = @input[pos].to_i # pocet uzlov
      
      #vytvor objekt grafu....
      @graph=Graph.new
      pos=pos+1


      

      for j in 0..node_count-1 # vytvaraj jendotlive nody
        # parsuj riadok
        @input[pos].chomp!
        tmp=@input[pos].split(" "); # parsuj riadok napr  1-uzol  2-pocet potomkov   3 4 -potomkovia
        n= Node.new  #vytvor uzol

        for k in 2..tmp.length-1 #prekopiruj potomkov
          n.childNodes[k-2] = tmp[k].to_i

        end
      
            
          @graph.nodes[j]=n


      pos=pos+1
      end

      #nacitaj metodu a pociatocny uzol
      tmp=@input[pos].chomp!

       puts "graph #{i+1}"

#      puts @graph

      while tmp!="0 0" #chyba ?
        x=tmp.split(" ")

        if x[1].to_i==1 # BFS

          

          @graph.BFS(x[0].to_i)
          @graph.restart_visit!

        else #DFS
          @graph.DFS(x[0].to_i)
          @graph.restart_visit!
#        @graph.recursive_DFS(x[0].to_i)
        end

       pos=pos+1
       tmp=@input[pos].chomp!

      end



    end #for
   
  
    


  

    end #def work



  end #class

s=Solver.new
s.do_work





