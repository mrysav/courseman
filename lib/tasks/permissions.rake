namespace :permissions do    
    desc "Restore admin permissions"
    task :give, [:user] => :environment do |task, args|
        begin
            user = User.find_by_email(args.user + '@d.umn.edu')
            user.admin = true
            user.save
            print "user " + args.user + " given admin permissions.\n"
        rescue
            print "user " + args.user + " doesn't exist!\n"
        end
    end

    desc "Revoke admin permissions"
    task :revoke, [:user] => :environment do |task, args|
        begin
            user = User.find_by_email(args.user + '@d.umn.edu')
            user.admin = false
            user.save
            print "user " + args.user + " revoked admin permissions.\n"
        rescue
            print "user " + args.user + " doesn't exist!\n"
        end
    end
end
