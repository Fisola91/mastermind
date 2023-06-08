class Attempt < ApplicationRecord
  belongs_to :player
  belongs_to :game

  serialize :values
end
