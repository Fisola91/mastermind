require "pry"
require "./app/constant_variable"
require "./app/computer_guesser"
class ApplicationController < ActionController::Base
  include ChancesAndGuesses
end
