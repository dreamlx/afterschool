class Api::V1::BaseController < ApplicationController

  private

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