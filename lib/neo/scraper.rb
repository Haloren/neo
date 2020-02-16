class Scraper
  #scrapes a full list of NEOs from website and makes a hash
  def scrape_neos 
    doc = Nokogiri::HTML(open("https://theskylive.com/near-earth-objects"))
    neo_rows = doc.css('tr.data') #doc.search('tr.data') each do |row|
    neo_rows.each do |row|
      neo_hash = {}
      neo_hash["name"] = row.css('a').text.strip
      neo_hash["date"] = row.css('td')[1].text.strip
      neo_hash["distance"] = row.css('td')[3].text.strip
      Neo.create_from_hash(neo_hash)
    # binding.pry
    end   
  end 
  # #scrapes only NEOs under .5 LD and make into a hash
  # def scrape_close_neos
  #   doc = Nokogiri::HTML(open("https://theskylive.com/near-earth-objects"))
  #   neo_rows = doc.css('tr.red')
  #   neo_rows.each do |row|
  #     neo_hash = {}
  #     neo_hash["name"] = row.css('a').text.strip
  #     neo_hash["date"] = row.css('td')[1].text.strip
  #     neo_hash["distance"] = row.css('td')[3].text.strip
  #     Neo.create_from_hash(neo_hash)
  #   # binding.pry
  #   end   
  # end 
end 