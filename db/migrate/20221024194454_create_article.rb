class CreateArticle < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :description
      t.text :article_text
      t.integer :author_id
      t.integer :category_id
      t.timestamps
    end
    
  end
end
