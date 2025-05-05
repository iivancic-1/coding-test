class PeopleController < ApplicationController
  def index
    # @people = Person.all
    # @people = Person.order(params[:sort]).includes(:locations, :affiliations).page(params[:page]).per(10)
    # @q = Person.ransack(params[:q])
    @q = Person.joins(:affiliations, :locations).ransack(params[:q])
    @people = @q.result(distinct: true).includes(:locations, :affiliations).page(params[:page]).per(10)
  end
end
