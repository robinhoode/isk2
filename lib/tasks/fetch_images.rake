
desc "Fetch images for titles"
task :fetch_images => :environment do
  Title.find_each do |t|
    t.attach_image! rescue nil
  end
end
