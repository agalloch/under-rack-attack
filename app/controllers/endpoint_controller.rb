require 'pry'

class EndpointController < ApplicationController
  use Rack::Attack
  use Attacked::Middleware

  def index
    puts 'shit'
    # binding.pry
  end
end