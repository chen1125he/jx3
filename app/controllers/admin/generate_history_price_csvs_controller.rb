# frozen_string_literal: true

class Admin::GenerateHistoryPriceCsvsController < Admin::BaseController
  def create
    @jid = Admin::GenerateHistoryPriceCsvWorker.perform_async(q: params[:q])
  end
end
