# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :user_id, presence: true


  def self.random_code
    random = false

    until random
      random = true
      random_code = SecureRandom.urlsafe_base64
      ShortenedUrl.exists?(short_url: random_code)
    end
    random_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!(short_url: short_url, long_url: long_url, user_id: user.id)
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitors

  def num_clicks
    visits.count
  end

  def num_uniques
    visits.select(:user_id).count
  end

  def num_recent_uniques
    visits.where("created_at > ?", 10.minutes.ago).select(:user_id).count
  end

end
