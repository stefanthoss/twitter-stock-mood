class AfinnAnalyzer
  def initialize path
    Rails.logger.info "Building dictionary"
    @dictionary = []
    file = File.new path, "r"
    while line = file.gets
      words = line.split "\t"
      @dictionary << { :word => words[0], :mood => words[1].to_i }
    end
    file.close
    Rails.logger.info "#{@dictionary.length} words in dictionary"
  end

  def analyze text
    positive = 0
    negative = 0
    @dictionary.each do |word|
      if text.downcase.include? word[:word]
        if word[:mood] > 0
          positive = positive + 1
        else
          negative = negative + 1
        end
      end
    end
    return { :positive => positive, :negative => negative }
  end
end
