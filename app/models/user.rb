class User < ApplicationRecord
  has_many :roadshows
  has_many :accesss
  has_many :latestpages

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
