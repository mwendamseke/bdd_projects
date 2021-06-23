Bsmi::Application.routes.draw do
  resources :deadlines

  resources :semesters

  resources :courses

  resources :cal_courses

  resources :districts

  resources :schools

  resources :user_sessions

  resources :settings


  match '/invites/new_excel' => 'invites#new_excel', :as => 'new_invite_excel'
  match '/invites/uploadFile_and_invite' => 'invites#uploadFile_and_invite', :as => 'uploadFile_and_invite'

  resources :invites


  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout

  resources :users  # give us our some normal resource routes for users
  resource :user, :as => 'account'  # a convenience route

  match '/user/adv_new' => 'users#adv_new', :as => 'advisor_new_user'
  match '/user/adv_create' => 'users#adv_create', :as => 'advisor_create_user'
  match '/user/:id/adv_show' => 'users#adv_show', :as => 'advisor_show_user'
  match '/user/:id/adv_edit' => 'users#adv_edit', :as => 'advisor_edit_user'
  match '/user/adv_edit' => 'users#adv_update', :as => 'advisor_update_user'

  match '/user/:id/user_show' => 'users#user_show', :as => 'user_show_user'

  match '/send_invitation/:id' => 'invites#send_invitation', :as => 'send_invitation'
  match '/signup/:invite_code' => 'users#new_no_email', :as => 'redeem_invitation'

  match 'signup' => 'users#new_no_email', :as => :signup

  resource :matching, :only => ['show', 'new', 'create', 'destroy']

  resources :cal_faculties

  resources :mentor_teachers do
    member do
      get 'home'
      get 'download_pdf'
    end
  end

  namespace :mentor_teacher do
    resources :my_students  
    resource :schedule    
  end

  namespace :cal_faculty do
    resources :my_students
    resources :my_mentor_teachers
    resources :my_cal_courses
    resources :home
  end


  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#home'
  
  match '/error' => 'pages#error'

  resources :advisors

  #match 'student/:stundet_id/send_student_report' => 'students#send_repo', :as => 'send_student_rep'
  #match '/send_student_report' => 'students#send_repo', :as => 'send_student_repo'
  resources :students do 
    resources :select_cal_courses
    resources :select_timeslots, :path => 'semesters/:semester_id/courses/:cal_course_id/select_timeslots' do
      get 'error'
    end
    member do 
      get 'download_pdf'
      get 'home'
      get 'splash', :path => 'semesters/:semester_id/splash'
      get 'placements', :path => 'semesters/:semester_id/placements'
      get 'edit_placements', :path => 'semesters/:semester_id/edit_placements'
      put 'edit_placements', :path => 'semesters/:semester_id/edit_placements'
      post 'edit_placements', :path => 'semesters/:semester_id/edit_placements'
      delete 'edit_placements', :path => 'semesters/:semester_id/edit_placements'
      get 'select_courses', :path => 'semesters/:semester_id/select_courses'
      put 'select_courses', :path => 'semesters/:semester_id/select_courses'
      get 'courses', :as => 'courses', :path => 'semesters/:semester_id/courses'
    end
  end
  match '/timeslots/destroy', :controller => :timeslots, :action => :destroy
  resources :timeslots
end
