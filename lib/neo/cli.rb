class CLI 
  def start 
    puts "NEO Start Menu"
    puts ""
    puts "------------------------------------------------------------------"
    puts "|Near Earth Objects (NEO):                                       |"
    puts "| Asteroids whose orbit is very close to intersect Earth's orbit.|"
    puts "|________________________________________________________________|"
      Scraper.new.scrape_neos
      menu_options
      start_menu
      terminate  
  end 
  def menu_options
    puts ""
    puts "What would you like to know?"
    puts "1. Get to know some NEOs" 
    # puts "#. Closest NEOs"
    puts "2. Credits" 
    puts "3. Exit"
    puts "------------------------------------------------------------------"
    puts "Please enter a number (1-3): "
  end 
  def start_menu
    input = nil 
    while input != "EXIT" 
      input = gets.strip.upcase 
      case input 
      when "1"
        neos_list
      # when "#"  
      #   closest_neos
      when "2"
        credits  
      when "3"
        terminate 
      else 
        puts ""
        puts ""
        puts "Returning to Main Menu."
        puts ""
        puts ""
        menu_options
      end
    end   
  end   
  def terminate
    puts ""
    puts "-----------------------------------------"
    puts "|Another NEO has passed safely by Earth.|" 
    puts "|See you on the next orbit.             |"
    puts "|---------------------------------------|" 
    puts "        Type 'Exit' to close"
  end   
  def neos_list 
    puts nil
    Neo.all.each.with_index(1){|n, index| puts "#{index}. #{n.name}" }
    puts ""
    puts "To see when and how close a NEO will arrive," #listed by date closest to furthest(1 - neo.count)
    puts "Enter a number: "
    input = gets.strip.upcase
    index = input.to_i - 1
    if (input.to_i - 1).between?(0, Neo.all.length) 
      neo_info(index) 
    else 
      puts "Invaild option. Returning to Main Menu"
      menu_options
    end 
  end 
  # def closest_neos
  #   Neo.
  # end 
  def neo_info(index)
    neo = Neo.all[index]

    puts neo.info
    
    puts "Type 'Yes' to see another NEO"
    puts "Type 'No' to return to Main Menu."
    
    input = gets.strip.upcase 
    if input == "YES"
      neos_list 
    elsif input == "Y"
      neos_list 
    else 
      start
    end   
  end   
  def credits 
    puts "" 
    puts "|-----------------Credits------------------|"
    puts "|NEO Data provided by:                     |"
    puts "|https://theskylive.com/near-earth-objects |"
    puts "|------------------------------------------|"
    puts "Type 'Menu' for main menu or 'Exit' to close"
  end   
  
end

