namespace :permissions do    
    desc "Restore admin permissions"
    task :give, [:user] => :environment do |task, args|
        set_admin(args.user, true)
    end

    desc "Revoke admin permissions"
    task :revoke, [:user] => :environment do |task, args|
        set_admin(args.user, false)
    end
    
    def set_admin(email, is_admin)
        begin
            user = User.find_by(email: email)
            user.admin = is_admin
            user.save!
            puts email + " is admin: " + is_admin.to_s
        rescue Exception => e
            puts e
        end
    end
end
