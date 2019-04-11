require 'rails_helper'

# Тест на шаблон users/show.html.erb

RSpec.describe 'users/show', type: :view do
  context 'when User watches own page' do

    before(:each) do
      @user = FactoryBot.create(:user, name: 'Oleg')
      @games = [FactoryBot.build_stubbed(:game, id: 1, created_at: Time.now, current_level: 5)]

      sign_in @user

      assign(:user, @user)
      assign(:games, @games)

      render
    end

    it 'renders current_user name' do
      expect(rendered).to match 'Oleg'
    end

    it 'renders button to change password' do
      expect(rendered).to match 'Сменить имя и пароль'
    end
  end

  context 'when User watches alien page' do

    before(:each) do
      @user = FactoryBot.build_stubbed(:user, name: 'Oleg')
      @games = [FactoryBot.build_stubbed(:game, id: 1, created_at: Time.now, current_level: 5)]

      assign(:user, @user)
      assign(:games, @games)

      render
    end

    it 'renders user name' do
      expect(rendered).to match 'Oleg'
    end

    it 'does not render button to change password' do
      expect(rendered).not_to match 'Сменить имя и пароль'
    end

    it 'renders fragments of game' do
      assert_template partial: 'users/_game', count: @games.count
    end
  end
end