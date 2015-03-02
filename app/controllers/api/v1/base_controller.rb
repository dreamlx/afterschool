class Api::V1::BaseController < ApplicationController

  private

  def format_paper(work_paper)
    Jbuilder.encode do |json|
      json.set! 'work_paper' do 
        json.id           work_paper.id
        json.title        work_paper.title
        json.type         work_paper.paper_type
        json.description  work_paper.description
        json.teacher      work_paper.teacher.nickname unless work_paper.teacher.nil?
        json.classes      work_paper.school_classes do |sc|
          json.school_class_id          sc.id
          json.class_no                 sc.class_no
        end
        json.medias work_paper.media_resources do |meida|
          json.media_resource_id        meida.id
          json.avatar                   meida.avatar.url
        end
      end
    end
  end

  def parse_data(base64_image)
    in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]
    #{暂时先这样}
    filename = "upload-data"

    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(string)
    @tempfile.rewind

    content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]
    extension = content_type.match(/gif|jpeg|png｜mp3|mp4|mov/).to_s
    filename += ".#{extension}" if extension

    ActionDispatch::Http::UploadedFile.new({
      tempfile: @tempfile,
      content_type: content_type,
      filename: filename
    })
  end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end

end