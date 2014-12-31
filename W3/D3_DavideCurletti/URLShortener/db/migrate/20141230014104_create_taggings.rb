class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.string :topic
      t.integer :shortened_url_id

      t.timestamps
    end

    add_column :shortened_urls, :tag_topic, :string
  end
end
