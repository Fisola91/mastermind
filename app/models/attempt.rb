class Attempt < ApplicationRecord
  belongs_to :player
  belongs_to :game

  serialize :values

  after_initialize do |b|
    b.values = [] if b.values == nil
  end
end
