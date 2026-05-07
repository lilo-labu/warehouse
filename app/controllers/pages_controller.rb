class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :offer, :opening]

  def home
  end

  def offer
  end

  def opening
  end
end
