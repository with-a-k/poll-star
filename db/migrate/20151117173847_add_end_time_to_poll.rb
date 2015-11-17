class AddEndTimeToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :end_time, :timestamp
  end
end
