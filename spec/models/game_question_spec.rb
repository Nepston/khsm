# (c) goodprogrammer.ru

require 'rails_helper'

# Тестовый сценарий для модели игрового вопроса,
# в идеале весь наш функционал (все методы) должны быть протестированы.
RSpec.describe GameQuestion, type: :model do

  # задаем локальную переменную game_question, доступную во всех тестах этого сценария
  # она будет создана на фабрике заново для каждого блока it, где она вызывается
  let(:game_question) { FactoryBot.create(:game_question, a: 2, b: 1, c: 4, d: 3) }

  # группа тестов на игровое состояние объекта вопроса
  describe '#variants' do
    # тест на правильную генерацию хэша с вариантами
    it 'return correct variants' do
      expect(game_question.variants).to eq({'a' => game_question.question.answer2,
                                            'b' => game_question.question.answer1,
                                            'c' => game_question.question.answer4,
                                            'd' => game_question.question.answer3})
    end
  end

  describe '#answer_correct?' do
    it 'return true if the answer is correct' do
      # именно под буквой b в тесте мы спрятали указатель на верный ответ
      expect(game_question.answer_correct?('b')).to be_truthy
    end
  end

  describe '#level' do
    it 'return correct current question level' do
      expect(game_question.level).to eq(game_question.question.level)
    end
  end

  describe '#text' do
    it 'return correct current question text' do
      expect(game_question.text).to eq(game_question.question.text)
    end
  end

  describe '#correct_answer_key' do
    it 'return correct answer key' do
      expect(game_question.correct_answer_key).to eq 'b'
    end
  end

  describe 'user helpers' do
    it 'correct audience_help' do
      expect(game_question.help_hash).not_to include(:audience_help)

      game_question.add_audience_help

      expect(game_question.help_hash).to include(:audience_help)

      ah = game_question.help_hash[:audience_help]
      expect(ah.keys).to contain_exactly('a', 'b', 'c', 'd')
    end
  end
end
