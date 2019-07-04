# frozen_string_literal: true

require 'test_helper'

class CreatorTest < ActionView::TestCase
  setup do
    new_time = Time.local(2018, 8, 10, 12, 0, 0)
    Timecop.freeze(new_time)
  end

  teardown do
    Timecop.return
  end


  test '#Should create first cell' do
    puts '------------------------'
    puts '#Should create first cell'
    player = Player.find_by_id(1)
    service = CellServices::Persist::Creator.new(player)
    service.call
    assert_equal true, service.valid?
    errors = service.errors
    assert_equal 0, errors.size
    assert_not_nil service.new_cell
    new_cell = service.new_cell
    assert_not_nil new_cell.pos_x
    assert_not_nil new_cell.pos_y
  end

  test '#Should create close cell' do
    puts '------------------------'
    puts '#Should create close cell'
    player = Player.find_by_id(2)
    service = CellServices::Persist::Creator.new(player)
    service.call
    assert_equal true, service.valid?
    assert_not_nil service.new_cell
    new_cell = service.new_cell
    assert_not_nil new_cell.pos_x
    assert_not_nil new_cell.pos_y
  end

  test '#Should not create cell on full world' do
    puts '------------------------'
    puts '#Should not create cell on full world'
    player = Player.find_by_id(3)
    service = CellServices::Persist::Creator.new(player)
    service.call
    assert_equal true, service.valid?
    assert_nil service.new_cell
  end

  test '#Should create cell on left of the current cell' do
    puts '------------------------'
    puts '#Should create cell on left of the current cell'
    player = Player.find_by_id(4)
    service = CellServices::Persist::Creator.new(player)
    service.call
    assert_equal true, service.valid?
    assert_not_nil service.new_cell
    new_cell = service.new_cell
    assert_equal new_cell.pos_x, 1
    assert_equal new_cell.pos_y, 0
  end

  test '#Should create cell under the current cell' do
    puts '------------------------'
    puts '#Should create cell under the current cell'
    player = Player.find_by_id(5)
    service = CellServices::Persist::Creator.new(player)
    service.call
    assert_equal true, service.valid?
    assert_not_nil service.new_cell
    new_cell = service.new_cell
    assert_equal new_cell.pos_x, 0
    assert_equal new_cell.pos_y, 1
  end

  test '#Should create cell on left enemy of the current cell' do
    puts '------------------------'
    puts '#Should create cell on left enemy of the current cell'
    player = Player.find_by_id(6)
    service = CellServices::Persist::Creator.new(player)
    service.call
    assert_equal true, service.valid?
    assert_not_nil service.new_cell
    new_cell = service.new_cell
    assert_equal new_cell.pos_x, 1
    assert_equal new_cell.pos_y, 0
  end


end
