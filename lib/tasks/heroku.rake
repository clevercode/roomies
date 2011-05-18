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

  desc "Returns all uninvited users"
  task :uninvited => :environment do
    User.where(invitation_sent_at: nil).each do |u|
      puts "#{u.name} - #{u.email} - created: #{u.created_at}"
    end
  end

end
