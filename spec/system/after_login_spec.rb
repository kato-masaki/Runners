# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:diary) { create(:diary, user: user) }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  
  describe 'ヘッダーのテスト' do
    context 'リンクの内容を確認' do
      subject { current_path }
      
      it '投稿一覧を押すと、投稿一覧画面に遷移する' do
        diaries_link = find_all('a')[1].native.inner_text
        diaries_link = diaries_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link diaries_link
        is_expected.to eq '/diaries'
      end
      it 'TOP3を押すと、ランキング画面に遷移する' do
        weekly_rank_link = find_all('a')[2].native.inner_text
        weekly_rank_link = weekly_rank_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link weekly_rank_link
        is_expected.to eq '/weekly_rank'
      end
      it 'HOMEを押すと、自分のユーザ詳細画面に遷移する' do
        home_link = find_all('a')[5].native.inner_text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq '/users/' + user.id.to_s
      end
    end
  end
  
  
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
end