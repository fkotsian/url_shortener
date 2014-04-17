class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true


  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many :visitors, through: :visits, source: :visitor, uniq: true

  def num_clicks
    ShortenedUrl.count { self.visits }
  end

  def num_uniques
    ShortenedUrl.distinct.count { self.visits }
  end

  def num_recent_uniques
    self.visits.select do |visit|
      visit.updated_at + 10.minutes > Time.now
    end.count
  end

  def self.random_code
    code = SecureRandom.urlsafe_base64
    until (ShortenedUrl.find_by :short_url, code).nil?
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!( user, long_url )
    ShortenedUrl.create!( long_url: long_url, short_url: self.random_code, user_id: user.id )
  end

end