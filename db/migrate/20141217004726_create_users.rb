class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      
    # omniauth-able properties
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :image
      
    # optional information properties
      t.string :student_id
      t.string :major
      t.string :minor
      t.string :collegiate_unit
      
    # other properties  
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
