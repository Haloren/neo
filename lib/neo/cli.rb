class CLI 
  def start 
    system "clear"
    puts "NEO Start Menu"
    puts ""
    puts "__________________________________________________________________"
    puts "|Near Earth Objects (NEO):                                       |"
    puts "| Asteroids whose orbit is very close to intersect Earth's orbit.|"
    puts "|________________________________________________________________|"
      Scraper.new.scrape_neos
      menu_options
      start_menu
      terminate  
  end 
  
  def menu_options
    puts "What would you like to know?"
    puts "1. Get to know some NEOs" 
    puts "2. Close NEOs (< 0.5 LD)" 
    puts "3. Credits" 
    puts "4. Exit"
    puts "------------------------------------------------------------------"
    puts "Please enter a number (1-4): "
  end 
  
  def start_menu
    input = nil 
    while input != "EXIT" 
      input = gets.strip.upcase 
      case input 
      when "1"
        neos_list
      when "2"  
        closest_neos
      when "3"
        credits  
      when "4"
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
    system "clear"
    puts ""
    puts "-----------------------------------------"
    puts "|Another NEO has passed safely by Earth.|" 
    puts "|See you on the next orbit.             |"
    puts "|---------------------------------------|" 
    puts ""
    puts "exit"
    exit 
  end   
  
  def neos_list 
    #Scraper.new.scrape_neos
    puts nil
    Neo.all.each.with_index(1){|n, index| puts "#{index}. #{n.name}" }
    puts ""
    puts "Which NEO would you like to learn about?"
    puts "(Listed by closest approach by date from 1 - #{Neo.all.length})"
    puts "Please enter a number: "
    input = gets.strip.upcase
    index = input.to_i - 1
    if (input.to_i - 1).between?(0, Neo.all.length) 
      neo_info(index) 
    else 
      puts "Returning to Main Menu"
      menu_options
    end 
  end 
  
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
  
  def closest_neos
    puts ""
    puts "2011 ES4 / 2020-Sep-01 16:12 / 0.31550 LD "
    puts ""
  end 
  
  def credits 
    system "clear"
    puts "" 
    puts "|-----------------Credits------------------|"
    puts "|    NEO Data provided by THE SKY LIVE     |"
    puts "|https://theskylive.com/near-earth-objects |"
    puts "|------------------------------------------|"
    puts ""
    puts "Type 'Menu' for main menu or 'Exit' to close"
  end   
  
end

