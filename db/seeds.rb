# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

# Import data from current course database
# VERY WEAK IMPORT; DOES NOT OVERWRITE UPDATED DATA
file = CSV.read("courses.csv")

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
    
        university = University.find_by_name(uni_name) || University.create(name: uni_name)
        location = university.locations.find_by_city_and_country(city_name, country_name) || university.locations.create(city: city_name, country: country_name)
    
        lib_eds = []
        if(lib_ed_cats)
            lib_eds = lib_ed_cats.split(';')
        end
    
        course = university.courses.find_by_name(course_name) || university.courses.create(code: course_code, name: course_name, language: language)
        umd_course = course.umd_courses.find_by_dept_and_code(dept, umd_course_code) || course.umd_courses.create(code: umd_course_code, name: umd_course_name, dept: dept, notes: note, lib_eds: lib_eds, approved: approved_date, approved_by: approved_name)
    
        review = course.reviews.find_by_dept(dept) || course.reviews.create(dept: dept, provider: provider, date_received: approved_date)
    
    rescue Exception => e
        puts e.message
        puts row.join(' | ')
    end
end
