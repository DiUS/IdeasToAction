ActiveAdmin.register IdeaAction, :as => "Action" do
  config.per_page = 10
  #menu :label => "Actions"

  index do
    column :description, :sortable => :description do |idea_action|
      truncate idea_action.description, :length => 100
    end

    column :idea do |idea_action|
      if idea_action.idea.present?
        link_to truncate(idea_action.idea_description, :length => 80), admin_idea_path(idea_action.idea)
      end
    end

    column :featured
    column :created_at
    column :updated_at
    default_actions
  end

  show do |idea_action|
    attributes_table do
      row :description
      row :idea do
        link_to idea_action.idea_description, admin_idea_path(idea_action.idea)
      end
      row :featured
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form :as => :idea_action do |f|
    f.inputs do
      f.input :idea_id, :label => 'Idea', :as => :select,
              :collection => Idea.all.map{ |i| ["(#{i.id}) #{i.description.truncate(35) }", i.id] }
      f.input :description
      f.input :featured
    end
    f.actions
  end

  filter :idea_id, :label => 'Idea', :as => :select,
          :collection => Idea.all.map{ |i| ["(#{i.id}) #{i.description.truncate(35) }", i.id] }
  filter :description
  filter :created_at
  filter :updated_at
  filter :featured

  member_action :new, :method => :get do
    @action = IdeaAction.new
  end

  member_action :create, :method => :post do
    @action = IdeaAction.new(params[:idea_action])

    if @action.save
      redirect_to admin_actions_path, :notice => "Action created successfully."
    else
      render 'new'
    end

  end
end
