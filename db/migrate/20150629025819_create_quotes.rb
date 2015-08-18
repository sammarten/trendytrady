class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes, :id => false do |t|
      t.integer :id, :limit => 8
      t.text :period
      t.datetime :time
      t.date :date
      t.decimal :open
      t.decimal :high
      t.decimal :low
      t.decimal :close
      t.integer :volume, :limit => 8
      t.references :security, index: true

      t.timestamps null: false
    end
    add_foreign_key :quotes, :securities
  end
end
