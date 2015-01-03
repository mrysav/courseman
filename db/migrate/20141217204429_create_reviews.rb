class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :dept
      t.datetime :date_sent
      t.datetime :date_due
      t.datetime :date_received
      t.string :note
      t.string :program_sponsor
      t.string :program_name
      t.string :program_term
      
      t.belongs_to :user
      t.belongs_to :course

      t.timestamps null: false
    end
  end
end
