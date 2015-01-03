class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.string :language
      
      # optional
      t.string :credits

      t.belongs_to :university

      t.timestamps null: false
    end
  end
end
