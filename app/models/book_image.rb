class BookImage < ActiveRecord::Base
  belongs_to :book
  mount_uploader :image_file, ImageFileUploader

  def attach_image!(image_file_url)
    if image_file.blank?
      self.remote_image_file_url = image_file_url 
      self.save! rescue nil
    end
  end
end
