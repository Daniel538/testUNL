class GetStatusesJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast "progress_channel", data
  end
end
