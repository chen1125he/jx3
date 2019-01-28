# frozen_string_literal: true

class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
end
