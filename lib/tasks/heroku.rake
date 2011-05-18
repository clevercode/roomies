namespace :stats do
  desc "Returns all users who have signed in at least once"
  task :visiters => :environment do
    User.where(:sign_in_count.ne => 0).each do |u|
      puts "#{u.name} - #{u.email} - last seen: #{u.last_sign_in_at}, invited: #{u.invitation_sent_at}"
    end
  end

  desc "Returns users who have never signed in"
  task :never => :environment do
    User.where(sign_in_count: 0).each do |u|
      puts "#{u.name} - #{u.email} - invited: #{u.invitation_sent_at}"
    end
  end

  task :all => [:visiters, :never]

end
