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
require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with username and password" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without username" do
    user = FactoryBot.build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid without password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with a duplicate username" do
    exist_user = FactoryBot.create(:user)
    duplicate_user = FactoryBot.build(:user, username: exist_user.username)
    duplicate_user.valid?
    expect(duplicate_user.errors[:username]).to include("has already been taken")
  end

  it "is invalid with a username longer than 320 characters" do
    user = FactoryBot.build(:user, username: "a" * 321)
    user.valid?
    expect(user.errors[:username]).to include("is too long (maximum is 320 characters)")
  end

  it "is invalid with a password shorter than 8 characters" do
    user = FactoryBot.build(:user, password: "a" * 7)
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
  end

  it "is invalid with a password longer than 72 characters" do
    user = FactoryBot.build(:user, password: "a" * 73)
    user.valid?
    expect(user.errors[:password]).to include("is too long (maximum is 72 characters)")
  end
end
