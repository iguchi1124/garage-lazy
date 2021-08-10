class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, type: :bigint
      t.references :article, null: false, type: :bigint
      t.text :body, null: false

      t.timestamps
    end
  end
end
