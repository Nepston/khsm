require 'rails_helper'

RSpec.feature 'User watches another user profile', type: :feature do
  let(:current_user) { FactoryBot.create :user, name: 'Oleg' }
  let(:another_user) { FactoryBot.create :user, name: 'Vladimir' }

  let!(:games) {
    [
      FactoryBot.create(:game, id: 3, user: another_user, prize: 32000, current_level: 10, is_failed: true,
                        created_at: '2019-04-11 10:18:37', finished_at: '2019-04-11 10:24:15'),
      FactoryBot.create(:game, id: 4, user: another_user, prize: 4000, current_level: 7, is_failed: false ,
                        created_at: '2019-04-11 10:30:46')
    ]
  }

  before(:each) do
    login_as current_user
  end

  # Сценарий успешного создания игры
  scenario 'successfully' do
    visit '/'

    click_link 'Vladimir'

    expect(page).not_to have_content 'Сменить имя и пароль'

    expect(page).to have_content '3'
    expect(page).to have_content 'проигрыш'
    expect(page).to have_content '11 апр., 10:18'
    expect(page).to have_content '32 000 ₽'
    expect(page).to have_content '10'


    expect(page).to have_content '4'
    expect(page).to have_content 'в процессе'
    expect(page).to have_content '11 апр., 10:30'
    expect(page).to have_content '4 000 ₽'
    expect(page).to have_content '7'
  end
end
