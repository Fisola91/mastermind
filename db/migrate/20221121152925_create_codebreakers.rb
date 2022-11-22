class CreateCodebreakers < ActiveRecord::Migration[7.0]
  def change
    create_table :codebreakers do |t|
      t.references :player, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
