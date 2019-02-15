# frozen_string_literal: true

class JobsController < ApplicationController
  def show
    data = Sidekiq::Status.get_all(params[:jid]) || {}
    payload = data['payload'] ? JSON.parse(data['payload']) : {}
    render json: { status: data['status'], total: data['total'], at: data['at'], message: data['message'], payload: payload }
  end
end
