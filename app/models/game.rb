class Game < ApplicationRecord
  has_many :attempts, dependent: :destroy
  has_one :valid_color

  after_initialize do |b|
    b.passcode = [] if b.passcode == nil
  end
end
