class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username, :total_points

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

  def self.by_karma
    User.order("total_points DESC")
  end

  def self.page(number)
    @users = User.by_karma.limit(10).offset(10 * number)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def total_karma
    self.total_points
  end

  def populate_total_points_column
    @users = User.find(:all, :include=>[:karma_points])
      @users.each do |user|
        value = []
        user.karma_points.each do |karma_point|
          value << karma_point.value
        end
        user.update_attribute(:total_points, value.reduce(:+))
      end
  end

end
