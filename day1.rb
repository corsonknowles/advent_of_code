# PART 1 
arr.sum { |n| n / 3 - 2 }

# PART 2
[10] pry(main)> def fuel(number)
[10] pry(main)*   number / 3 - 2
[10] pry(main)* end
[13] pry(main)> def keep_fueling(number, sum = 0)           
[13] pry(main)*   top_up = fuel(number)                       
[13] pry(main)*   return sum if top_up <= 0   
[13] pry(main)*              
[13] pry(main)*   sum += top_up += keep_fueling(top_up, sum)  
[13] pry(main)* end 

[23] pry(main)> my_proc = Object.method(:keep_fueling)
[27] pry(main)> array.sum &my_proc


In time, this is O(N * ln(M)) where N is the number of integers and M is the size of those integers. 
In terms of space, it's  O(ln(M)) since the recursion will need to grab each number in the keep_fueling stack. 
