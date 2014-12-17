class CreateUmdCourses < ActiveRecord::Migration
  def change
    create_table :umd_courses do |t|
      t.string :code
      t.string :name
      t.string :dept
      t.datetime :approved
      t.string :approved_by
      t.string :notes

      t.belongs_to :course
      t.timestamps null: false
    end
  end
end
