require 'securerandom'
require 'byebug'

class ShortenedUrl < ActiveRecord::Base
    include SecureRandom

    def self.random_code
      hash = SecureRandom::urlsafe_base64
      while ShortenedUrl.exists?(short_url: hash)
        hash = SecureRandom::urlsafe_base64
      end
      hash
    end

    def self.prune(n)
      self.all
      .joins('LEFT JOIN visits ON shortened_urls.id = short_url_id')
       .where('(short_url_id IS NOT null AND visits.updated_at < ?) OR
              (short_url_id IS null AND shortened_urls.created_at < ?)' ,n.minutes.ago, n.minutes.ago).delete_all

    end

    def self.generate_short_url(user, long_url)
      hash = self.random_code
      ShortenedUrl.create!(short_url: hash, long_url: long_url,
      user_id: user.id)
      hash
    end

    def num_clicks
      self.visits.count
    end

    def num_unique
      self.unique_visitors.count
    end

    def num_recent_uniques
      self.visits.where('created_at > ?', 10.minutes.ago)
      .select(:user_id).distinct.count
    end

    private

    def five_links_per_min
      recent_submits = self.class.all
      .where('created_at > ? AND user_id = ?', 1.minutes.ago, submitter.id )
      .count
      if recent_submits >= 5
        errors[:base] << "Too many link submissions in last minute"
      end
    end

    def nonpremium_max
      if submitter.submitted_urls.count > 5 && submitter.premium == false
        errors[:base] << "Reached non-premium max"
      end
    end


    validate :five_links_per_min
    validate :nonpremium_max
    validates :short_url, presence: true
    validates :short_url, uniqueness: true
    validates :long_url, presence: true
    validates :user_id, presence: true

    belongs_to :submitter,
      primary_key: :id,
      foreign_key: :user_id,
      class_name: :User

    has_many :visits,
      primary_key: :id,
      foreign_key: :short_url_id,
      class_name: :Visit

    has_many :visitors,
      through: :visits,
      source: :user

    has_many :unique_visitors,
      Proc.new { distinct },
      through: :visits,
      source: :user

      has_many :tag_topics,
        through: :taggings,
        source: :topic

      has_many :taggings,
        primary_key: :id,
        foreign_key: :short_url_id,
        class_name: :Tagging

end
