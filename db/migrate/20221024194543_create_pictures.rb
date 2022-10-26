class CreatePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :pictures do |t|
      t.string :name
      t.text :image_url
      t.integer :article_id
    end
  end
end
