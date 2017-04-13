class TagTopic < ApplicationRecord
  validates :topic, presence: true

  def popular_links
      self.urls
      .joins(:visits)
      .group(:id)
      .order("count(visits.id) desc")
      .limit(2)
  end

  has_many :urls,
    through: :taggings,
    source: :short_url

  has_many :taggings,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :Tagging
end
