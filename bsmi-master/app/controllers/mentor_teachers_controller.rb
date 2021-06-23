require "prawn"

class MentorTeachersController < ApplicationController
  # GET /mentor_teachers
  # GET /mentor_teachers.json
  before_filter :require_user
  def index
    @all_teacher = User.where(:owner_type => "MentorTeacher")
    if params[:sort] || session[:sort] != nil
      sort = params[:sort] || session[:sort]
      case sort
      when 'first_name'
         @all_teacher = @all_teacher.order(:first_name)
      when 'last_name'
         @all_teacher = @all_teacher.order(:last_name)
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mentor_teachers }
    end
  end
  
  # GET /mentor_teachers/1
  # GET /mentor_teachers/1.json
  def show
    store_location
    @mentor_teacher = MentorTeacher.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mentor_teacher }
    end
  end

  # GET /mentor_teachers/new
  # GET /mentor_teachers/new.json
  def new
    @mentor_teacher = MentorTeacher.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mentor_teacher }
    end
  end

  # GET /mentor_teachers/1/edit
  def edit
    @mentor_teacher = MentorTeacher.find(params[:id])
  end

  # POST /mentor_teachers
  # POST /mentor_teachers.json
  def create
    @mentor_teacher = MentorTeacher.new(params[:mentor_teacher])

    respond_to do |format|
      if @mentor_teacher.save
        format.html { redirect_to @mentor_teacher, notice: 'Mentor teacher was successfully created.' }
        format.json { render json: @mentor_teacher, status: :created, location: @mentor_teacher }
      else
        format.html { render action: "new" }
        format.json { render json: @mentor_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mentor_teachers/1
  # PUT /mentor_teachers/1.json
  def update
    @mentor_teacher = MentorTeacher.find(params[:id])

    respond_to do |format|
      if @mentor_teacher.update_attributes(params[:mentor_teacher])
        format.html { redirect_to @mentor_teacher, notice: 'Mentor teacher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mentor_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentor_teachers/1
  # DELETE /mentor_teachers/1.json
  def destroy
    @mentor_teacher = MentorTeacher.find(params[:id])
    @mentor_teacher.destroy_all

    respond_to do |format|
      format.html { redirect_to mentor_teachers_url }
      format.json { head :no_content }
    end
  end

  def home
  end

  def download_pdf
    teacher = MentorTeacher.find(params[:id])
    send_data generate_pdf(teacher),
              filename: "#{teacher.user.name}.pdf",
              type: "application/pdf"
  end
 
  private
  def generate_pdf(teacher)
    Prawn::Document.new do
      text "UC Berkeley", :size => 20, :align => :right, :style => :bold
      stroke {y=@y-30; line [1,y], [bounds.width,y]}
      text "CalTeach Mentor Teacher Report", :size => 24, :align => :center, :style => :bold
      text "Date: #{Time.now.to_s}"
      text "Name: #{teacher.user.name}"
      text "Address: #{teacher.user.street_address}" 
      text "Email: #{teacher.user.email}"

      teacher.timeslots.each do |timeslot| 
        students = timeslot.students
        students.collect!{|student| ['Student' , student.user.name]}
        entry = timeslot.build_entry(teacher.id)
        school = entry["school_name"]
        course = entry["course"] ? entry["course"].name : " "
        grade = entry["course"] ? entry["course"].grade : " "
        description = timeslot.semester ? timeslot.semester.description : " "
        name = timeslot.cal_course ? timeslot.cal_course.name : " "
        time = entry["time"]
        data = [ ['Semester', description],
                 ['Cal Course', name],
                 ['School', school],
                 ['Course', course],
                 ['Grade', grade],
                 ['Time', time],
        ]
        data += students
        move_down(30)
        table data, :header => false, :column_widths => {0 => 80, 1 => 400}
      end
    end.render
  end
end
