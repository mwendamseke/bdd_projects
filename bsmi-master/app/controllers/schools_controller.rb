class SchoolsController < ApplicationController
  before_filter :require_admin, :only => [:index, :show, :new, :edit]

  # GET /schools
  def index
    @schools = School.all

  end

  # GET /schools/1
  def show
    @school = School.find(params[:id])
  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
    @school = School.find(params[:id])
  end

  # POST /schools
  def create
    if params[:school][:district]
      params[:school][:district] = District.find(params[:school][:district])
    end

    @school = School.new(params[:school])

    if @school.save
      redirect_to @school, notice: 'School was successfully created.'
    else
      render action: "new" 
    end
  end

  # PUT /schools/1
  def update
    @school = School.find(params[:id])

    if params[:school][:district]
      params[:school][:district] = District.find(params[:school][:district])
    end

    @school.update_attributes(params[:school])

    if @school.save
      redirect_to @school, notice: 'School was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /schools/1
  def destroy
    @school = School.find(params[:id])
    @school.destroy

    redirect_to schools_url
  end
end
