class WorksController < ApplicationController
  before_action :find_work, :check_work, only: [:show, :edit, :update, :destroy]
  
  def index
    @works = Work.all    
  end

  def show
    check_work
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(id: @work.id)
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category} "
      render :new, status: :bad_request
      return
    end
  end

  def edit
    check_work
  end

  def update
    check_work
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(id: @work.id)
    else
      flash.now[:error] = "Unsuccessfull update of #{@work.title}"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    if @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to root_path
    end
  end

  private
  def find_work
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)
  end

  def check_work
    if @work.nil?
      redirect_to works_path, notice: 'Work not found'
      return
    end
  end

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end