class Api::V1::BaseController < ApplicationController

  private

  def format_homeworks(home_works)
    Jbuilder.encode do |json|
      json.array! home_works do |home_work|
        json.id           home_work.id
        json.title        home_work.title
        json.description  home_work.description
        json.state        home_work.state
        json.created_at   home_work.created_at
        json.updated_at   home_work.updated_at
        json.work_paper do |w|
          unless home_work.work_paper.nil?
            json.id home_work.work_paper.id
            json.title  home_work.work_paper.title
          end
        end
        json.medias home_work.media_resources do |media|
          json.media_resource_id        media.id
          json.avatar                   media.avatar.url
          json.content_type          media.content_type
          json.file_size                media.file_size
        end
        json.teacher do
          unless home_work.work_paper.nil?
            json.avatar   home_work.work_paper.teacher.profile.nil? ? '' :home_work.work_paper.teacher.profile.avatar.url
            json.teacher  home_work.work_paper.teacher.nickname
          end
        end
        json.student do
          json.avatar   home_work.student.profile.nil? ? "" : home_work.student.profile.avatar.url
          json.student  home_work.student.nickname
          json.student_id  home_work.student.id
        end
      end
    end
  end

  def format_homework(home_work)
    Jbuilder.encode do |json|
      json.set! 'home_work' do
        json.id           home_work.id
        json.title        home_work.title
        json.description  home_work.description
        json.state        home_work.state
        json.created_at   home_work.created_at
        json.updated_at   home_work.updated_at
        json.work_paper_id  home_work.work_paper_id
        json.work_paper do
          unless home_work.work_paper.nil?
            json.id home_work.work_paper.id
            json.title  home_work.work_paper.title
          end
        end
        json.medias home_work.media_resources do |media|
          json.media_resource_id        media.id
          json.avatar                   media.avatar.url
          json.content_type          media.content_type
          json.file_size                media.file_size
        end
        json.teacher do
          unless home_work.work_paper.nil?
            json.avatar   home_work.work_paper.teacher.profile.nil? ? '' :home_work.work_paper.teacher.profile.avatar.url
            json.teacher home_work.work_paper.teacher.nickname
          end
        end
      end
    end
  end


  def format_papers(work_papers, student_id)
    Jbuilder.encode do |json|
      json.array! work_papers do |work_paper|
        json.id           work_paper.id
        json.title        work_paper.title
        json.type         work_paper.paper_type
        json.description  work_paper.description
        json.count_works  work_paper.count_works
        json.total_students  work_paper.total_students

        unless student_id.blank?
          json.home_work_state   work_paper.home_work_state(student_id)
        end
        json.teacher do |teacher|
          unless work_paper.teacher.nil?
            json.teacher      work_paper.teacher.nickname
            json.avatar       work_paper.teacher.profile.nil? ? "" : work_paper.teacher.profile.avatar.url
          end
        end

        json.created_at    work_paper.created_at
        json.updated_at    work_paper.updated_at
        json.classes      work_paper.school_classes do |sc|
          json.school_class_id          sc.id
          json.class_no                 sc.class_no
        end
        json.medias work_paper.media_resources do |media|
          json.media_resource_id        media.id
          json.avatar                   media.avatar.url
          json.content_type          media.content_type
          json.file_size                media.file_size
        end
      end
    end
  end

  def format_paper(work_paper)
    Jbuilder.encode do |json|
      json.set! 'work_paper' do
        json.id           work_paper.id
        json.title        work_paper.title
        json.type         work_paper.paper_type
        json.description  work_paper.description
        json.teacher do |teacher|
          unless work_paper.teacher.nil?
            json.teacher      work_paper.teacher.nickname
            json.avatar       work_paper.teacher.profile.nil? ? "" : work_paper.teacher.profile.avatar.url
          end
        end
        json.created_at    work_paper.created_at
        json.updated_at    work_paper.updated_at
        json.classes      work_paper.school_classes do |sc|
          json.school_class_id          sc.id
          json.class_no                 sc.class_no
          json.total_students           sc.total_students
          json.submit_students          sc.submit_students(work_paper.id)
        end
        json.medias work_paper.media_resources do |media|
          json.media_resource_id        media.id
          json.avatar                   media.avatar.url
          json.content_type          media.content_type
          json.file_size                media.file_size
        end
      end
    end
  end


  protected

  def paged(customer, per_page = 12 )
    customer.page(params[:page]).per(per_page)
  end

  private

  def render_error message
    render json: { error: { message: message } }
  end

  def render_msg message
    render json: { message: message }
  end


end
