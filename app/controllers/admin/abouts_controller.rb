module Admin
  class AboutsController < ApplicationController
    before_action :set_admin_about, only: %i[ edit update ]
  
    # GET /admin/abouts or /admin/abouts.json
    def index
        redirect_to edit_admin_about_path(1)
    end
  
    # GET /admin/abouts/1 or /admin/abouts/1.json
    def show
      redirect_to edit_admin_about_path(1)
    end
  
    # GET /admin/abouts/1/edit
    def edit
    end
  
    # PATCH/PUT /admin/abouts/1 or /admin/abouts/1.json
    def update
      respond_to do |format|
        if @admin_about.update(admin_about_params)
          format.html { redirect_to admin_about_url(@admin_about), notice: "About was successfully updated." }
          format.json { render :show, status: :ok, location: @admin_about }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @admin_about.errors, status: :unprocessable_entity }
        end
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_admin_about
        @admin_about = About.find(1)
      end
  
      # Only allow a list of trusted parameters through.
      def admin_about_params
        params.require(:about).permit(:page, :map_location)
      end
  end
end