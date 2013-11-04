class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username, :total_karma

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}

  before_validation :karma_points


  def self.by_karma
        User.order("total_karma DESC")
    # joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def karma_points
    value = []
    self.find(:all, :include=>[:karma_points])
    self.karma_points.each do |karma_point|
      value << karma_points.value
    end
    self.update_attribute(total_karma, value.reduce(:+))
  end

  # def total_karma
  #   self.karma_points.sum(:value)
  # end

end
