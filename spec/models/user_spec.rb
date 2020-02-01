require 'rails_helper'

describe User do
  describe '#create' do
    #１ページ目の全ての項目が存在すれば登録できる
    it "is valid with a nickname, last_name, first_name, last_name_kana, first_name_kana, password, password_confirmation, birthday_year, birthday_month, birthday_date" do
      user = build(:user)
      expect(user).to be_valid
    end
    
    it "is invalid without a nickname" do
    #nicknameが空だと登録できない
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
    #last_nameが空だと登録できない
    it "is invalid without a last_name" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end
    #first_nameが空だと登録できない
    it "is invalid without a first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end
    #last_name_kanaが空だと登録できない
    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end
    #first_name_kanaが空だと登録できない
    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end
    #passwordが空だと登録できない
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    #password_confirmationが空だと登録できない
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    #birthday_yearが空だと登録できない
    it "is invalid without a birthday_year" do
      user = build(:user, birthday_year: "")
      user.valid?
      expect(user.errors[:birthday_year]).to include("can't be blank")
    end
    #birthday_monthが空だと登録できない
    it "is invalid without a birthday_month" do
      user = build(:user, birthday_month: "")
      user.valid?
      expect(user.errors[:birthday_month]).to include("can't be blank")
    end
    #birthday_dateが空だと登録できない
    it "is invalid without a birthday_date" do
      user = build(:user, birthday_date: "")
      user.valid?
      expect(user.errors[:birthday_date]).to include("can't be blank")
    end

    #passwordが6文字以上であれば登録できること
    it "is valid with a password that has more than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user).to be_valid
    end

    #passwordが5文字以下であれば登録できないこと
    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    #emailが重複していると登録できない
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

  end
end