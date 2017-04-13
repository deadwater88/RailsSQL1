class Tagging < ApplicationRecord
  validates :topic_id, presence: true
  validates :short_url_id, presence: true

  belongs_to :topic,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :TagTopic

  belongs_to :short_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :ShortenedUrl
end
