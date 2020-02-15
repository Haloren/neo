class CLI 
  def start  
    puts "Near Earth Objects(NEOs):"
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
    puts "2. Close passing NEOs"
    puts "3. 99942 Apophis" #make this an option after a user exits and add credits 
    puts "4. Exit"
    puts ""
  end 
  
  def start_menu
    input = nil 
    while input != "EXIT" 
      puts "Please enter a number or type 'Exit': " 
      input = gets.strip.upcase 
      case input 
      when "1"
        neos_list
      when "2"
        close_pass
      when "3"
        apophis 
      when "4"
        terminate 
      else 
        puts "Invaild option. Returning to Main Menu"
        menu_options
      end
    end   
  end   
  
  def terminate
    puts "" 
    puts "Another NEO has passed safely by Earth." 
    puts "See you on the next orbit."
  end   
  
  def neos_list 
    puts nil
    Neo.all.each.with_index(1){|n, index| puts "#{index}. #{n.name}" }
 
    puts "Select a NEO to see how close it will get to Earth and how soon."
    
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
    puts "or press any key to return to start."
    
    input = gets.strip.upcase 
    if input == "YES"
      neos_list 
    else 
      start_menu
    end   
  end   
    
  def apophis 
    puts "" 
    puts "99942 Apophis was discovered June 19, 2004," 
    puts "by Roy A. Tucker, David J. Tholen, and Fabrizio Bernardi."
    puts "With a diameter of 450 meter, taller than the Effile Tower, it will be "
    puts "visible with the naked eye, on it's closest approach (April 13, 2029)"
    puts "This approach puts Apophis around 31,000 kilometres from Earth." 
    puts "That's 10 times closer than the moon!" 
    puts "So until 2029, Apophis the Great Serpent, we'll be seeing you."
  end   
  
  def close_pass   
    puts "NEOs within half the distance to the moon: "
    
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
    
    Astroid Name:             #{name}
    
    Approach Date:        #{date}
    Nearest Approach :   #{distance} (Lunar Distance)
    
    INFO
  end 
  
end
  