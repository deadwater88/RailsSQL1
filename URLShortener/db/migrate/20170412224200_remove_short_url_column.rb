class RemoveShortUrlColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :tag_topics, :short_url_id
  end
end
