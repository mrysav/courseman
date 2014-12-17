class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :country
      
      t.belongs_to :university
      
      t.timestamps null: false
    end
  end
end
