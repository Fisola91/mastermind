class ValidColor < ApplicationRecord
  serialize :colors
  scope :passcode, -> { select(:colors)
                        .first[:colors]
                        .shuffle
                        .take(4) }

  after_initialize do |b|
    b.colors = [] if b.colors == nil
  end
end
