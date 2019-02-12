class DownloadFilesController < ApplicationController
  def create
    filepath = params[:filepath]
    return if filepath.blank?
    return unless File.exists?(Rails.root.join(filepath))

    filename = params[:filename].presence || File.basename(filepath)
    return if filename.blank?

    mime_type = MIME::Types.type_for(File.extname(filename)).first
    send_file filepath, type: mime_type.content_type, disposition: 'attachment', filename: filename
  end
end
