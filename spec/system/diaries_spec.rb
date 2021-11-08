# frozen_string_literal: true

require 'rails_helper'

  describe '投稿画面(new_diary_path)のテスト' do
    before do
      visit new_diary_path
    end
    context '表示の確認' do
      it 'new_diary_pathが"/diaries/new"であるか' do
        expect(current_path).to eq('/diaries/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'diary[caption]', with: Faker::Lorem.characters(number:30)
        fill_in 'diary[distance]', with: Faker::Number.number(2)
        fill_in 'diary[hour]', with: Faker::Number.number(2)
        fill_in 'diary[minute]', with: Faker::Number.number(2)
        fill_in 'diary[second]', with: Faker::Number.number(2)
        fill_in 'diary[pace_minute]', with: Faker::Number.number(2)
        fill_in 'diary[pace_second]', with: Faker::Number.number(2)
        click_button '投稿'
        expect(page).to have_current_path diaries_path
      end
    end
  end