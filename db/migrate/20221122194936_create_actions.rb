class CreateActions < ActiveRecord::Migration[7.0]
  def change
    create_table :actions do |t|
      t.string :type
      t.text :body
      t.string :source

      t.timestamps
    end
  end
end
