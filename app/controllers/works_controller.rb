class WorksController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.where(category: 'album')
    @books = Work.where(category: 'book')
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "#{@work.title} was added"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:failure] = "Could not add #{@work.title}"
      render: new, status: :bad_request
      return
    end
  end

end
