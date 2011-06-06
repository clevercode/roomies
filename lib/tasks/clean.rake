namespace :clean do
  desc "Deletes all records from User model"
  task :users => :environment do
    puts "===== deleting all User records ====="
    User.delete_all
  end

  desc "Deletes all records from House model"
  task :houses => :environment do
    puts "===== deleting all House records ====="
    House.delete_all
  end

  desc "Deletes all records from Assignment models"
  task :assignments => :environment do
    puts "===== deleting all Assignment records ====="
    Assignment.delete_all
  end

  desc "Deletes all records from Achievement models"
  task :achievements => :environment do
    puts "===== deleting all Achievement records ====="
    Achievement.delete_all
  end

  desc "Deletes all records from Authentication models"
  task :authentications => :environment do
    puts "===== deleting all Authentication records ====="
    Authentication.delete_all
  end

  desc "Deletes all records from HouseInvitation models"
  task :house_invitations => :environment do
    puts "===== deleting all HouseInvitation records ====="
    HouseInvitation.delete_all
  end

  desc "Deletes all records from Reward models"
  task :rewards => :environment do
    puts "===== deleting all Reward records ====="
    Reward.delete_all
  end


  task :all => [
                  :users, 
                  :houses, 
                  :assignments, 
                  :achievements, 
                  :authentications,
                  :house_invitations,
                  :rewards

  ]
end

