namespace :permissions do
    desc "Restore admin permissions"
    task restore: :environment do
        begin
            rysau001 = User.find_by_email('rysau001@d.umn.edu')
            rysau001.admin = true
            rysau001.save
            print "user rysau001 given admin permissions.\n"
        rescue
            print "user rysau001 doesn't exist!"
        end
    end

end
