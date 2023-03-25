# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  password_digest :string
#  username        :string(320)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  has_many :movies, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: {maximum: 320}
  validates :password, presence: true, length: {minimum: 8}
end
