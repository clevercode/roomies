namespace :stats do
  task :visiters => :environment do
    User.where(:sign_in_count.ne => 0).each do |u|
      puts "#{u.name} - #{u.email} - last seen: #{u.last_sign_in_at}, invited: #{u.invitation_sent_at}"
    end
  end

  task :never => :environment do
    User.where(sign_in_count: 0).each do |u|
      puts "#{u.name} - #{u.email} - invited: #{u.invitation_sent_at}"
    end
  end

  task :all => [:visiters, :never]

end
