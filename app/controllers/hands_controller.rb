class HandsController < ApplicationController
  def index
    @hands = Hand.new(params[:s_hands]) if params[:s_hands].present?
  end
end

