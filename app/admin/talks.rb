ActiveAdmin.register Talk do
  config.per_page = 10

  index do
    column :title
    column :description, :sortable => :description do |talk|
      truncate talk.description, :length => 100
    end
    column "Event" do |talk|
      link_to talk.event_name, admin_event_path(talk.event)
    end
    column :featured
    column :viewable
    column :created_at
    column :updated_at
    default_actions
  end
end
