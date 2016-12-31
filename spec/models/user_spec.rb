require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:valid_user) { FactoryGirl.create(:user) }

  context "invalid user" do
    it "is not valid without a name" do
      @user = FactoryGirl.build(:user, name: nil)
      expect(@user).not_to be_valid
    end

    context "email" do
      it "is not valid without an email" do
        @user = FactoryGirl.build(:user, email: nil)
        expect(@user).not_to be_valid,
        "User #{@user.name} should not have been valid without an email"
      end

      it "is not valid without a unique e-mail" do
        @user = FactoryGirl.build(:user, email: valid_user.email)
        expect(@user).not_to be_valid,
        "User #{@user.name} should not have been valid with a duplicate email"
      end
    end

    context "password" do
      it "is not valid without a password" do
        skip
        @user = FactoryGirl.create(:user, password: nil)
        expect(@user).not_to be_valid
      end
    end
  end

  context "valid user" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:user).save)
    end
  end
end
