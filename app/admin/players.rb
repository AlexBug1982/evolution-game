# frozen_string_literal: true

include ActiveAdmin::ViewsHelper
ActiveAdmin.register Player do
  menu label: 'Player'

  actions :index, :show, :edit, :update, :destroy
  scope :all
  permit_params :player_name, :color

  index do
    selectable_column
    id_column
    column :player_name
    column :created_at
    column :world
    column :color
    actions
  end

  form do |f|
    f.inputs 'Player' do
      f.input :player_name
      f.input :color, :as => :string
    end
    f.actions
  end

end
