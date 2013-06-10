module StocksHelper

  def get_latest_quote symbol
    YahooFinance::get_standard_quotes(symbol).each do |s, q|
      return q
    end
  end

end
