class AddCoursesToReviews < ActiveRecord::Migration[5.0]
  def change
      # Home course info
      add_column :reviews, :course_code, :string
      add_column :reviews, :course_name, :string
      add_column :reviews, :course_credits, :string
      add_column :reviews, :course_notes, :string
      add_column :reviews, :course_approved_by, :string
      add_column :reviews, :course_approved, :datetime
      add_column :reviews, :course_categories, :string, array: true
      
      # Foreign course info
      add_column :reviews, :foreign_name, :string
      add_column :reviews, :foreign_code, :string
      add_column :reviews, :foreign_language, :string
      add_column :reviews, :foreign_credits, :string
      add_column :reviews, :foreign_university_id, :integer
      
      # For Carrierwave uploads
      add_column :reviews, :syllabus, :string
  end
end
