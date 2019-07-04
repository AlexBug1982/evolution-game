class CreateCellsJob < ApplicationJob
  queue_as :default

  def perform
    service = CellServices::Runtime::CreateCellsService.new
    service.call
  end
end
