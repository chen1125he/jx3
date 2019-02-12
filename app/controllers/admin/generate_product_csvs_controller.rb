# frozen_string_literal: true

class Admin::GenerateProductCsvsController < Admin::BaseController
  def create
    @jid = Admin::GenerateProductCsvWorker.perform_async
  end
end
