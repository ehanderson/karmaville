class KarmaPoint < ActiveRecord::Base
  attr_accessible :user_id, :label, :value
  belongs_to :user

  validates :user, :presence => true
  validates :value, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :label, :presence => true

  after_save :update

  def update
    user = User.find(self.user_id)
    user.update_attribute(:total_points, (user.total_points + self.value))
  end

end
