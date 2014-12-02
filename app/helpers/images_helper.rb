module ImagesHelper
  def images_for_select(images)
    options = []
    images.each do |image|
      image.repo_tags.each do |rt|
        options << ["#{rt[:repo]}:#{rt[:tag]}", image.short_id]
      end
    end
    options
  end
end
