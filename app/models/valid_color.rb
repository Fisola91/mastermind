class ValidColor < ApplicationRecord
  serialize :colors

  after_initialize do |b|
    b.colors = [] if b.colors == nil
  end
end
