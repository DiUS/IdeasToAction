ActiveAdmin.register Idea do
  config.per_page = 10

  index do
    column :description, :sortable => :description do |idea|
      truncate idea.description, :length => 100
    end
    column :featured
    column :created_at
    column :updated_at
    default_actions
  end

  show do |idea|
    attributes_table do
      row :description
      row :member do
        "(#{idea.member_id}) #{idea.member_username ? idea.member_username : 'Anonymous'}"
      end
      row :featured
      row :created_at
      row :updated_at
      row :talks do
        idea.talks.collect{ |t| t.title }.join(", ")
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :member_id, :label => 'Member', :as => :select,
              :collection => Member.all.map{|m| ["(#{m.id}) #{m.username ? m.username : 'Anonymous'}", m.id]}
      f.input :description
      f.input :featured
      f.input :talks, :as => :check_boxes

    end
    f.actions
  end

  filter :member_id, label: 'Member', as: :select, collection: proc{Member.usernames}
  filter :description
  filter :created_at
  filter :updated_at
  filter :featured
end
