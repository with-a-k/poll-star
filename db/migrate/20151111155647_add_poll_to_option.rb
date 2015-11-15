class AddPollToOption < ActiveRecord::Migration
  def change
    add_reference :options, :poll, index: true, foreign_key: true
  end
end
