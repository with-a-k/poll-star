class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :body
      t.integer :votes

      t.timestamps null: false
    end
  end
end
