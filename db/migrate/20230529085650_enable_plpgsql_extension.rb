class EnablePlpgsqlExtension < ActiveRecord::Migration[7.0]
  def change
    def change
      enable_extension 'plpgsql'
    end
  end
end
