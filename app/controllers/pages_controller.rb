class PagesController < ApplicationController
  def home
    @trabalhos = []
    3.times do |i|
      # Checar se já tem um trabalho cadastrado na data
      if Trabalho.new(data: Date.today - i, user_id: current_user.id).valid?
        @trabalhos << Trabalho.new(data: Date.today - i)
      else
        @trabalhos << Trabalho.find_by(data: Date.today - i)
      end
    end
    # Encontrei um método no API do Active Record que pode ser útil
    # find_or_create_by(att: value) returns the first item or creates it and returns it.
  end
end
