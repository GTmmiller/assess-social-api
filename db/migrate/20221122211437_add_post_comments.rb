class AddPostComments < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.references :posts, null: false, foreign_key: true
    end
  end
end
