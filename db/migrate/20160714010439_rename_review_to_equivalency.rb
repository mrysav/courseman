class RenameReviewToEquivalency < ActiveRecord::Migration[5.0]
  def change
    rename_table :reviews, :equivalencies
  end
end
