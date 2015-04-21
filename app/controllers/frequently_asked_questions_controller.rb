class FrequentlyAskedQuestionsController < ApplicationController
  def index
    @questions = {
      about:            'Какво е Бъдещето е код?',
      non_commercial:   'Комерсиална инициатива ли е?',
      payment:          'Ще бъда ли възмезден като лектор?',
      who:              'Кой го организира?',
      motivation:       'Мотивация',
      history:          'История',
      mechanism:        'Механизъм',
      logistics:        'Организация и логистика',
      content:          'Съдържание на презентациите',
      meetups:          'Сбирки след часовете',
      followup:         'Последващи дейности',
      schedule:         'График и времетраене',
      join:             'Как да се включите',
      spread_the_word:  'Популяризация на събитието',
      opensource:       'Отворен код',
      contacts:         'Контакти',
    }
  end
end
