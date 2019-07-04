task create_cells_task: :environment do
  service = CellServices::Runtime::CreateCellsService.new
  service.call
end
