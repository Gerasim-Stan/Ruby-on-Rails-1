class CreateTableArticlesTags < ActiveRecord::Migration
  def change
    create_table :articles_tags do |t|
      t.references :article, null: false
      t.references :tag,     null: false
    end

    add_index :articles_tags, [:article_id, :tag_id]
  end
end
