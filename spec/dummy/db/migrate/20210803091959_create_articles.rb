class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.references :user, type: :bigint, null: false
      t.string :slug, null: false, index: true
      t.string :title, null: false
      t.text :description
      t.text :body, null: false

      t.timestamps
    end
  end
end
