class Admin::UsersController < Admin::ApplicationController
  before_action :set_admin_user, only: %i[ show edit update destroy toggle ]

  before_action :page_by_page, only: %i[ index ]

  # after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index

  # GET /admin/users or /admin/users.json
  def index
    authorize [:admin, User]
  end

  # GET /admin/users/1 or /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    authorize [:admin, User]
    @admin_user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users or /admin/users.json
  def create
    @admin_user = User.new(admin_user_params)
    authorize [:admin, @admin_user]

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to admin_users_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: [:admin, @admin_user] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1 or /admin/users/1.json
  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to admin_user_url(@admin_user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1 or /admin/users/1.json
  def destroy
    @admin_user.destroy

    # render nothing: true, status: 204
    respond_to do |format|
      # format.html { redirect_to admin_users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # TOGGLE /admin/users/:id/toggle(.:format)
  def toggle
    authorize [:admin, User]
    @admin_user.update_column(:active, !@admin_user.active)

    # render nothing: true, status: 204
    respond_to do |format|
      # format.html { redirect_back(fallback_location: admin_users_path) }
      format.json { head  :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = authorize [:admin, User.find(params[:id])]
    end

    # Only allow a list of trusted parameters through.
    def admin_user_params
      params.require(:user).permit(:name, :email)
    end

    def page_by_page
      per_page = User.paginates_per 4
      users = policy_scope(User, policy_scope_class: Admin::UserPolicy::Scope).all
      
      users_count = users.count
      @total_pages = users_count / per_page + (users_count % per_page > 0 ? 1 : 0)
      @current_page = params[:page].nil? ? 0 : params[:page]

      redirect_to admin_users_path if @current_page.to_i > @total_pages.to_i || @current_page.to_i < 0

      @admin_users = users.page(@current_page).includes(:role).order(:name)
    end
  end
