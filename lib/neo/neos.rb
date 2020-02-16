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
    tap{@@all << self} #returns self.tap 
  end 
  def info 
    <<~INFO 
    --------------------------------------------------
     Astroid Name:       #{name}                    
    
     Approach Date:      #{date}
     Nearest Approach :  #{distance} (Lunar Distance)
    --------------------------------------------------
    INFO
  end   
end