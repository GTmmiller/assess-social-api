class AddReferences < ActiveRecord::Migration[7.0]
  def change
    change_table :actions do |t|
      t.references :user, null: false, foreign_key: true
    end

    change_table :posts do |t|
      t.references :user, null: false, foreign_key: true
    end
  end
end
