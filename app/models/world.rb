# == Schema Information
#
# Table name: worlds
#
#  id         :bigint(8)        not null, primary key
#  slug       :string           not null
#  width      :integer          not null
#  height     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class World < ApplicationRecord
  has_many :cells, dependent: :destroy
  has_many :players, dependent: :destroy

  validates :slug, presence: true
  validates :width, presence: true
  validates :height, presence: true
  before_validation :slugify

  def slugify
    self.slug = unique_world_slug
  end

  def json_cells
    cells.to_json(:only => [ :pos_x, :pos_y ], :include => { :player => {:only => [:color, :player_name]}})
  end

  private

  def unique_world_slug
    is_unique = false
    until is_unique
      slug = SecureRandom.hex(8).upcase
      is_unique = !World.exists?(slug: slug)
    end
    slug
  end
end
