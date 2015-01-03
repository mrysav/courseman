class CreateUmdCourses < ActiveRecord::Migration
  def change
    create_table :umd_courses do |t|
      t.string :code
      t.string :name
      t.string :designator
      t.datetime :approved
      t.string :approved_by
      t.string :notes
      t.string :lib_eds, array: true

      # optional
      t.string :credits

      t.belongs_to :review
      
      t.timestamps null: false
    end
  end
end
