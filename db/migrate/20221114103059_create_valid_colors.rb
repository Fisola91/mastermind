class CreateValidColors < ActiveRecord::Migration[7.0]
  def change
    create_table :valid_colors do |t|
      t.text :colors, array:true
      t.timestamps
    end
  end
end
