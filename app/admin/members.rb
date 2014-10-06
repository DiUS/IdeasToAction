ActiveAdmin.register Member do
  config.per_page = 10

  index do
    column :email
    column :created_at
    column :updated_at
    default_actions
	end

	form do |f|
		f.inputs do
			f.input :email
		end
		f.actions
	end

  csv do
    column :email
    column :created_at
    column :updated_at
	end

	filter :created_at
	filter :updated_at
	filter :email

	controller do
		def show
			@member = Member.find params[:id]
		end

		def new
			@member = Member.new
		end

		def create
			@member = Member.new params[:member]

			if @member.save
				redirect_to admin_member_path(@member), notice: 'Member created successfully.'
			else
				render 'new'
			end
		end

		def edit
			@member = Member.find params[:id]
		end

		def update
			@member = Member.find params[:id]
			if @member.update_attributes(params[:member])
				redirect_to admin_member_path(@member), notice: 'Member updated successfully.'
			else
				render 'edit'
			end
		end

		def destroy
			@member = Member.find params[:id]
			@member.destroy
			redirect_to admin_members_path, notice: 'Member was successfully destroyed.'
		end
	end
end
