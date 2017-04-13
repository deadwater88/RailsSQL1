class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :email, presence: true

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

  has_many :visits,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Visit

  has_many :visited_urls,
    through: :visits,
    source: :shortened_url

  has_many :unique_visited_urls,
    Proc.new{distinct},
    through: :visits,
    source: :shortened_url

end
