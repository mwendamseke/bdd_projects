class Semester < ActiveRecord::Base
  PUBLIC = "Public"
  PRIVATE = "Private"
  FALL = "Fall"
  SPRING = "Spring"
  SUMMER = "Summer"

  SEASONS = [FALL, SPRING, SUMMER]
  STATUSES = [PUBLIC, PRIVATE]

  default_scope order('start_date DESC')

  attr_protected #none
  has_and_belongs_to_many :cal_facultys
  has_and_belongs_to_many :mentor_teachers
  has_and_belongs_to_many :students
  has_many :cal_courses, :uniq => true
  has_many :preferences, :through => :timeslots
  has_many :timeslots, :through => :cal_courses
  belongs_to :registration_deadline, :class_name => "Deadline", :dependent => :destroy

  accepts_nested_attributes_for :registration_deadline, :cal_courses

  validates_length_of :year, :is => 4

  validates_inclusion_of :name, :in => SEASONS
  validates_inclusion_of :status, :in => STATUSES
  validates_presence_of :registration_deadline

  SEASON = ["Spring", "Summer", "Fall"]

  def <=>(other)
    result = self.year <=> other.year
    if result == 0
      result = Semester::SEASON.index(self.name) <=> Semester::SEASON.index(other.name)
    end
  end

  def description
    self.name + " " + self.year.to_s
  end

  def self.createSelection
    selection = []
    Semester.all.each do |semester|
      selection << semester.description
    end
    return selection
  end

  def self.getSemester(description)
    if description
      name, year = description.split
      semester = Semester.where(:year => year.to_i, :name => name)
      if semester.length > 0
        return semester[0]
      end
    end
  end

  def self.current_semester
    sem = Semester.where("start_date < ?", Date.today).where("end_date > ?", Date.today).where(:status => "Public")
    if sem
      return sem.first
    end 
    sem = Semester.where("end_date > ?", Date.today).where(:status => "Public").order("end_date ASC")
    if sem
      return sem.first
    end

    nil
  end

  def self.past_deadline?(semester_id)
    semester = Semester.find(semester_id)
    if semester.registration_deadline
      DateTime.now > semester.registration_deadline.due_date
    else
      false
    end
  end

  def reset_matchings
    Matching.joins(:timeslot).
      where("timeslots.semester_id" => self.id).destroy_all
    self.matchings_performed = false
    self.save
  end

end
