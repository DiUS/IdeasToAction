ActiveAdmin.register IdeaAction, :as => "Action" do
  config.per_page = 10

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
    column :target_date
		column :completion_date
		column :completed, :sortable => :completion_date do |idea_action|
			idea_action.completed?
		end
		column :member do |idea_action|
			link_to idea_action.member_email, admin_member_path(idea_action.member)
		end
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
			row :target_date
			row :completion_date
			row :member do
				link_to idea_action.member_email, admin_member_path(idea_action.member.id)
			end
    end
  end

  form :as => :idea_action do |f|
    f.inputs do
      f.input :idea, :label => 'Idea', :as => :select,
              :collection => Idea.all.map{ |i| ["(#{i.id}) #{i.description.truncate(35) }", i.id] }
      f.input :description
      f.input :featured
			f.input :target_date, as: :datepicker
			f.input :completion_date, as: :datepicker
    end
    f.actions
  end

  filter :idea_id, label: 'Idea', as: :select, collection: proc{Idea.descriptions}
  filter :description
  filter :created_at
  filter :updated_at
  filter :target_date
  filter :completion_date
  filter :featured
	filter :member_id, label: 'Member', as: :select, collection: proc{Member.emails}
	scope :incomplete
	scope :completed
	scope :all

  controller do
    def new
      @action = IdeaAction.new
    end

    def create
      @action = IdeaAction.new(params[:idea_action])

      if @action.save
        redirect_to admin_actions_path, :notice => "Action created successfully."
      else
        render 'new'
      end
    end
  end
end
