class AddRatingRelations < ActiveRecord::Migration[7.0]
  def change
    change_table :ratings do |t|
      t.references :rater, index: true, null: false, foreign_key: { to_table: :users }
      t.references :ratee, index: true, null:false, foreign_key: { to_table: :users }
    end
  end
end
