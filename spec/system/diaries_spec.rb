# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  describe '投稿画面(diaries_new_path)のテスト' do
    before do
      visit diaries_new_path
    end
    context '表示の確認' do
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill _in 'diary[caption]', with: Faker::Lorem.characters(number:30)
        fill _in 'diary[distance]', with: Faker::Number.number(2)
        fill _in 'diary[hour]', with: Faker::Number.number(2)
        fill _in 'diary[minute]', with: Faker::Number.number(2)
        fill _in 'diary[second]', with: Faker::Number.number(2)
        fill _in 'diary[pace_minute]', with: Faker::Number.number(2)
        fill _in 'diary[pace_second]', with: Faker::Number.number(2)
        click_button '投稿'
        expect(page).to have_current_path diaries_path
      end
    end
  end
end