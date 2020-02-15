class CLI 
  def start 
    puts "NEO Start Menu"
    puts ""
    puts "Near Earth Objects (NEO):"
    puts " Asteroids whose orbit is very close to intersect Earth's orbit."
      Scraper.new.scrape_neos
      menu_options
      start_menu
      terminate  
  end 
  
  def menu_options
    puts ""
    puts "What would you like to know?"
    puts "1. Get to know some NEOs" 
    puts "2. Credits" 
    puts "3. Exit"
    puts "Please enter a number (1-3): "
  end 
  
  def start_menu
    input = nil 
    while input != "EXIT" 
      input = gets.strip.upcase 
      case input 
      when "1"
        neos_list
      when "2"
        credits  
      when "3"
        terminate 
      else 
        puts ""
        puts ""
        puts "Invaild option. Returning to Main Menu."
        puts ""
        puts ""
        menu_options
      end
    end   
  end   
  
  def terminate
    puts ""
    puts "Another NEO has passed safely by Earth." 
    puts "See you on the next orbit."
    puts "" 
    puts "Type 'Exit' to close"
  end   
  
  def neos_list 
    puts nil
    Neo.all.each.with_index(1){|n, index| puts "#{index}. #{n.name}" }
 
    puts ""
    puts "To see how close and when the NEO will arrive," #asteroids are listed in closest to furthest
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
    puts "NEO Data provided by:"
    puts "https://theskylive.com/near-earth-objects"
    puts ""
    puts "Type 'Menu' for main menu or 'Exit' to close"
  end   
  
end


class Scraper
  def scrape_neos 
    doc = Nokogiri::HTML(open("https://theskylive.com/near-earth-objects"))
    neo_rows = doc.css('tr.data')
  
    neo_rows.each do |row|
      neo_hash = {}
      
      neo_hash["name"] = row.css('a').text.strip
      neo_hash["date"] = row.css('td')[1].text.strip
      neo_hash["distance"] = row.css('td')[3].text.strip
      Neo.create_from_hash(neo_hash)
    end   
  end 
  
end 
    
    
class Neo 
  @@all = []
  attr_accessor :name, :date, :distance 
  
  def self.create_from_hash(hash)
    n = Neo.new
    hash.each do |key, value|
      n.send("#{key}=", value) if n.methods.include?("#{key}=".to_sym) 
    end 
    n.save
  end   

  def self.all
    @@all 
  end   

  def save
    tap{@@all << self}#returns self.tap 
  end 
  
  def info 
    <<~INFO 
    
    Astroid Name:       #{name}
    
    Approach Date:      #{date}
    Nearest Approach :  #{distance} (Lunar Distance)
    
    INFO
  end 
  
end
  