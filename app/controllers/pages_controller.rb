class PagesController < ApplicationController
  def home
    @trabalhos = []
    3.times do |i|
      @trabalhos << Trabalho.new #(data: Date.today - i)
    end
  end
end
