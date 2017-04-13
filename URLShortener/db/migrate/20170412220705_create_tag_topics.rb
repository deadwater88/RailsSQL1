class CreateTagTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_topics do |t|
      t.string :topic, null: false
      t.integer :short_url_id, null: false
      t.timestamps
    end

    add_index :tag_topics, :topic
    add_index :tag_topics, :short_url_id
  end
end
