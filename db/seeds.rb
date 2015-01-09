# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

# account to import reviews under
user = User.find_by_email('rysau001@d.umn.edu')

# Import data from current course database
# VERY WEAK IMPORT; DOES NOT OVERWRITE UPDATED DATA
file = CSV.read("import/courses.csv")

headers = file.shift
print headers.inspect + "\n\n\n"

file.each do |row|
    
    provider = row[0]
    country_name = row[1]
    uni_name = row[2]
    city_name = row[3]
    course_code = row[4]
    course_name = row[5]
    language = row[6]
    dept = row[7]
    umd_course_name = row[8]
    umd_course_code = row[9]
    note = row[10]
    lib_ed_cats = row[11]
    lib_ed_cat_ids = row[12]
    approved_name = row[13]
    approved_date = row[14]
    syllabus = row[15]
    
    begin
    
        university = University.find_by_name_and_city_and_country(uni_name, city_name, country_name) || University.create(name: uni_name, city: city_name, country: country_name)
    
        lib_eds = []
        if(lib_ed_cats)
            lib_eds = lib_ed_cats.split(';')
        end
   
        if syllabus && syllabus != ''
            syl_file = File.new('import/syllabi/' + syllabus)
            course = university.courses.create(code: course_code, name: course_name, language: language, syllabus: syl_file)
        else
            course = university.courses.create(code: course_code, name: course_name, language: language)
        end 

        course = university.courses.create(code: course_code, name: course_name, language: language, syllabus: syl_file)
        
        review = Review.create(dept: dept, program_sponsor: provider, date_received: approved_date, course_id: course.id, status: :approved)
                
        umd_course = UmdCourse.create(review_id: review.id, code: umd_course_code, name: umd_course_name, designator: dept, notes: note, lib_eds: lib_eds, approved: approved_date, approved_by: approved_name)
    
    
    rescue Exception => e
        puts e.message
        puts row.join(' | ')
    end
end
