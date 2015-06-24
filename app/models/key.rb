require SecureRandom

class Key < ActiveRecord::Base
  belongs_to :user

  validates :key, presence: true
  validates :user, presence: true

  before_validation :create_key!, on: :create

  private

  def create_key!
    self.key = SecureRandom.uuid
  end

end
