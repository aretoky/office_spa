require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /new" do
    before do
      get signup_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "there is a new registration screen" do
      expect(response.body).to include "新規登録"
    end

    it "label display test" do
      expect(response.body).to include "フルネーム"
      expect(response.body).to include "メールアドレス"
      expect(response.body).to include "パスワード(6文字以上)"
      expect(response.body).to include "パスワード(確認用)"
      expect(response.body).to include "作成する"
    end
  end

  describe "GET /edit" do
    let!(:user) { create :user }

    before do
      sign_in_as user
      get edit_user_path(user.id)
    end

    it "edit label test" do
      expect(response.body).to include "名前"
      expect(response.body).to include "メールアドレス"
      expect(response.body).to include "パスワード(６文字以上)"
      expect(response.body).to include "パスワード(確認用)"
      expect(response.body).to include "編集する"
    end
  end

  describe "GET /show" do
    let!(:user) { create :user }

    before do
      sign_in_as user
      get user_path(user.id)
    end

    it "response test" do
      expect(response).to have_http_status(200)
      expect(response.body).to include user.name
      expect(response.body).to include "編集する"
    end
  end

  describe "GET /index" do
    let!(:users) { create_list(:users, 5) }
    let!(:admin) { create :admin }

    before do
      sign_in_as admin
      get users_path
    end

    it "index user test" do
      users.each do |user|
        expect(response.body).to include user.name
      end
    end
  end

  describe "delete user" do
    let!(:admin) { create :admin }

    it "user delete success" do
      sign_in_as admin
      get users_path
      expect(response.body).to include "削除する"
    end
  end
end
