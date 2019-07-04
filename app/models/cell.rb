# frozen_string_literal: true
# == Schema Information
#
# Table name: cells
#
#  id         :bigint(8)        not null, primary key
#  pos_x      :integer          not null
#  pos_y      :integer          not null
#  player_id  :bigint(8)
#  world_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cell < ApplicationRecord
  belongs_to :world
  belongs_to :player

  validates :pos_x, presence: true
  validates :pos_y, presence: true
  validates :player, presence: true
end
