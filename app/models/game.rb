class Game < ApplicationRecord
  has_many :attempts, dependent: :destroy
  has_one :valid_color
  has_many :codebreakers

  serialize :passcode
end
