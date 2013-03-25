ActiveAdmin.register Interaction do
  config.per_page = 10

  index do
    column :action do |interaction|
      if interaction.idea_action.present?
        link_to truncate(interaction.idea_action_description, :length => 200), admin_action_path(interaction.idea_action)
      end
    end

    column :reaction_text, :sortable => :reaction_text do |interaction|
      truncate interaction.reaction_text, :length => 200
    end

    column :created_at
    column :updated_at

    default_actions
  end

  show do |interaction|
    attributes_table do
      row :member do
        "(#{interaction.member_id}) #{interaction.member_username ? interaction.member_username : 'Anonymous'}"
      end
      row :action do
        link_to interaction.idea_action_description, admin_action_path(interaction.idea_action)
      end
      row :reaction_text
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :member_id, :label => 'Member', :as => :select,
              :collection => Member.all.map{|m| ["(#{m.id}) #{m.username ? m.username : 'Anonymous'}", m.id]}
      f.input :idea_action_id, :label => 'Action', :as => :select,
              :collection => IdeaAction.all.map{ |a| ["(#{a.id}) #{a.description.truncate(35) }", a.id] }
      f.input :reaction_text
    end
    f.actions
  end

  filter :idea_action_id, :label => 'Action', :as => :select,
         :collection => IdeaAction.all.map{ |a| ["(#{a.id}) #{a.description.truncate(35) }", a.id] }
  filter :member_id, :label => 'Member', :as => :select,
         :collection => Member.all.map{ |m| ["(#{m.id}) #{m.username ? m.username : 'Anonymous'}", m.id] }
  filter :reaction_text
  filter :created_at
  filter :updated_at

end
