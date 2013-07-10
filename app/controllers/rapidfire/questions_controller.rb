module Rapidfire
  class QuestionsController < ApplicationController
    before_filter :authenticate_administrator!
    respond_to :html, :js

    before_filter :find_question_group!
    before_filter :find_question!, :only => [:edit, :update, :destroy]

    def index
      @questions = @question_group.questions
      respond_with(@questions)
    end

    def new
      @question = QuestionProxy.new(:question_group => @question_group)
      respond_with(@question)
    end

    def create
      proxy_params = params[:question].merge(:question_group => @question_group)
      @question = QuestionProxy.new(proxy_params)
      @question.save

      respond_with(@question, location: index_location)
    end

    def edit
      @question = QuestionProxy.new(:question => @question)
      respond_with(@question)
    end

    def update
      proxy_params = params[:question].merge(:question => @question)
      @question = QuestionProxy.new(proxy_params)
      @question.save

      respond_with(@question, location: index_location)
    end

    def destroy
      @question.destroy
      respond_with(@question, location: index_location)
    end

    private
    def find_question_group!
      @question_group = QuestionGroup.find(params[:question_group_id])
    end

    def find_question!
      @question = @question_group.questions.find(params[:id])
    end

    def index_location
      rapidfire.question_group_questions_url(@question_group)
    end
  end
end
