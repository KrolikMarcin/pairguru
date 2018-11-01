class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.timestamps
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true
    end
  end
end
