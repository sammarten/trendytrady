class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :symbol
      t.string :name
      t.integer :time_in_mins

      t.timestamps null: false
    end
  end
end
