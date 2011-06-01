module ApplicationHelper
  def title
    base_title = "Roomies makes living together easier"
    short_title = "Roomies"

    if @title.nil?
      base_title
    else
      "#{short_title} | #{@title}"
    end
  end

  def random_image
    image_files = %w( .jpg .gif .png )
    files = Dir.entries(
      "#{RAILS_ROOT}/public/images/support" 
    ).delete_if { |x| !image_files.index(x[-4,4]) }
    files[rand(files.length)]
  end

  private
  def roomies_list 
    @roomies = User.where(house_id: current_user.house_id)
    @roomies.each do |roomie|
      if roomie.name.blank?
        roomie.name = roomie.email
        roomie.save
      end
    end
  end

end
