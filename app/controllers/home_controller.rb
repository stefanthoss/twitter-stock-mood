class HomeController < ApplicationController
  def index
    @streams = Stream.all
  end
end
