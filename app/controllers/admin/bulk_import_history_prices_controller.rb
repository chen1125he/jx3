# frozen_string_literal: true

class Admin::BulkImportHistoryPricesController < Admin::BaseController
  def new
  end

  def create
    @jid = Admin::BulkImportHistoryPricesWorker.perform_async(params[:file]&.path, current_service.id)
  end
end
