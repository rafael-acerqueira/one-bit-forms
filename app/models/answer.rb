class Answer < ApplicationRecord
  belongs_to :form
  has_many :questions_answers, dependent: :destroy
  accepts_nested_attributes_for :questions_answers

  def self.create_with_question_answers form, questions_answers
    answer = nil
    ActiveRecord::Base.transaction do
      answer = Answer.create(form: form)
      questions_answers.each do |qa|
        answer.questions_answers.create(value: qa['value'], question_id: qa['question']['id'])
      end
    end
    answer
  end
end
