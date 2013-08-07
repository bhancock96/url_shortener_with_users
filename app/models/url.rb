class Url < ActiveRecord::Base
belongs_to :user

  validates_presence_of :name

  validates :name, format: {with: /http:\/\/.+/, message: "Must be valid URL" }
  validates :short_url, presence: true

  # # create our callback
  before_validation :shorten_url

  private
  def shorten_url
    if !self.short_url
      self.short_url = SecureRandom.urlsafe_base64(4)
    end
  end

end
