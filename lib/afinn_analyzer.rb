class AfinnAnalyzer
  def initialize
    @dictionary = []
    file = File.new "AFINN-111.txt", "r"
    while line = file.gets
      words = line.split "\t"
      @dictionary << { :word => words[0], :mood => words[1].to_i }
    end
    file.close
    puts "#{@dictionary.length} words in dictionary"
  end

  def analyze text
    sentiment = 0
    @dictionary.each do |word|
      sentiment = sentiment + word[:mood] if text.downcase.include? word[:word]
    end
    return sentiment
  end
end
