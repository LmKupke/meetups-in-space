class Meetup < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  belongs_to :user
  validates :user, presence: true
  has_many :usermeetups
  has_many :users, through: :usermeetups
end
