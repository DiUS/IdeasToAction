ActiveAdmin.register Member do
  config.per_page = 10

  index do
    column :username
    #column :email
    column :created_at
    column :updated_at
    default_actions
  end

  csv do
    column :username
    #column :email
    column :created_at
    column :updated_at
  end

end
