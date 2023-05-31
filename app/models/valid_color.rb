class ValidColor < ApplicationRecord
  scope :passcode, -> { select(:colors)
                        .first[:colors]
                        .shuffle
                        .take(4) }
end
