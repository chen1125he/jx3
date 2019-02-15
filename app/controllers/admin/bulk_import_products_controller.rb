# frozen_string_literal: true

class Admin::BulkImportProductsController < Admin::BaseController
  def new
  end

  def create
    @jid = Admin::BulkImportProductsWorker.perform_async(params[:file]&.path)
  end
end
