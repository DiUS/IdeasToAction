ActiveAdmin.register Event do
  config.per_page = 10

  index do
    column :name
    column :description, :sortable => :description do |event|
        truncate event.description, :length => 100
    end
    column :featured
    column :created_at
    column :updated_at
    default_actions
  end
end
