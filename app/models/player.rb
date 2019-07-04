# frozen_string_literal: true
# == Schema Information
#
# Table name: players
#
#  id            :bigint(8)        not null, primary key
#  session_token :string
#  player_name   :string           not null
#  color         :string           not null
#  world_id      :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Player < ApplicationRecord
  has_many :cells, dependent: :destroy
  belongs_to :world

  validates :player_name, presence: true
  validates :world, presence: true


  def self.create_unique_session_token
    is_unique = false
    until is_unique
      new_session_token = SecureRandom.urlsafe_base64(nil, false).to_s
      is_unique = !Player.where(session_token: new_session_token).exists?
    end
    new_session_token
  end
end
