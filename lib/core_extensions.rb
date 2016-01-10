class String
  def red
    "\033[31m#{self}\033[0m" 
  end #adding red 
  
  def cyan
    "\033[36m#{self}\033[0m" 
  end #adding cyan
end