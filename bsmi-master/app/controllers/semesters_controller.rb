class SemestersController < ApplicationController
  before_filter :require_admin, :only => [:index, :show, :new, :edit]


  # GET /semesters
  # GET /semesters.json
  def index
    @semesters = Semester.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @semesters }
    end
  end

  # GET /semesters/1
  # GET /semesters/1.json
  def show
    @semester = Semester.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @semester }
    end
  end

  # GET /semesters/new
  # GET /semesters/new.json
  def new
    @semester = Semester.new
    @registration_deadline = Deadline.new
    @cal_courses = CalCourse.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @semester }
    end
  end

  # GET /semesters/1/edit
  def edit
    @semester = Semester.find(params[:id])
    @registration_deadline = @semester.registration_deadline
    @cal_courses = CalCourse.all
  end

  # POST /semesters
  # POST /semesters.json

  def create
    if params[:semester][:cal_courses]
      params[:semester][:cal_courses] = params[:semester][:cal_courses].map { |c| CalCourse.find(c) }
    end
    @semester = Semester.new(params[:semester])
    @registration_deadline = Deadline.new(params[:registration_deadline])
    @semester.registration_deadline = @registration_deadline
    @cal_courses = CalCourse.all

    respond_to do |format|
      if @semester.valid? and @registration_deadline.valid?
        @registration_deadline.save
        @semester.save
        format.html { redirect_to @semester, notice: 'Semester was successfully created.' }
        format.json { render json: @semester, status: :created, location: @semester }
      else
        format.html { render action: "new" }
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end
  # PUT /semesters/1
  # PUT /semesters/1.json
  def update
    @semester = Semester.find(params[:id])
    @cal_courses = CalCourse.all
    @semester.registration_deadline.update_attributes(params[:registration_deadline])

    if params[:semester][:cal_courses]
      params[:semester][:cal_courses] = params[:semester][:cal_courses].map { |c| CalCourse.find(c) }
    end

    if @semester.update_attributes(params[:semester])
      redirect_to @semester, notice: 'Semester was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /semesters/1
  # DELETE /semesters/1.json
  def destroy
    @semester = Semester.find(params[:id])
    #@semester.registration_deadline.destroy
    @semester.destroy

    respond_to do |format|
      format.html { redirect_to semesters_url }
      format.json { head :no_content }
    end
  end
end
