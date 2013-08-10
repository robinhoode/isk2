class ChangeFileToImageFileOnImages < ActiveRecord::Migration
  def change
    rename_column :images, :file, :image_file
  end
end
