class AddClosedToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :closed, :boolean
  end
end
