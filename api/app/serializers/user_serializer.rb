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
class UserSerializer < Panko::Serializer
  attributes :username
end
