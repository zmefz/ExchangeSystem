class QuestionsController < ApplicationController
  skip_before_action :require_admin!, only: [:create]
  skip_before_action :require_user!, only: [:create]
  before_action :set_question, only: [:destroy]

  def index
    @questions = Question.all
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      render json: { success: true }
    else
      render json: { success: true, errors: @question.errors, message: @question.errors.full_message }
    end
  end

  def destroy
    @question.destroy
    render json: { success: true }
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:message, :name, :email)
    end
end
