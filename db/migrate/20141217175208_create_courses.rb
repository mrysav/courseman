class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.string :program
      t.string :language

      t.belongs_to :university

      t.timestamps null: false
    end
  end
end
