# frozen_string_literal: true

include ActiveAdmin::ViewsHelper
ActiveAdmin.register Player do
  menu label: 'Player'

  actions :index
  scope :all

  index do
    selectable_column
    id_column
    column :player_name
    column :created_at
  end
end
