ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recently Created Events" do
          table_for Event.order("created_at desc").limit(5) do
            column :name
            column :created_at
          end
          strong { link_to "View All Events", admin_events_path }
        end
      end

      column do
        panel "Recently Created Talks" do
          table_for Talk.order("created_at desc").limit(5) do
            column :title
            column :created_at
          end
          strong { link_to "View All Talks", admin_talks_path }
        end
      end
    end

    columns do
      column do
        panel "Recently Created Ideas" do
          table_for Idea.order("created_at desc").limit(5) do
            column :description do |idea|
              truncate idea.description, :length => 200
            end
            column :created_at
          end
          strong { link_to "View All Ideas", admin_ideas_path }
        end
      end
    end
  end
end
