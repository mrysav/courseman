# # TODO: Fix this
#
# require 'csv'
#
# # account to import equivalencies under
# user = User.find_by_email('rysau001@d.umn.edu')
#
# # Import data from current course database
# # VERY WEAK IMPORT; DOES NOT OVERWRITE UPDATED DATA
#
# CSV.foreach("import/courses.csv").each_with_index do |row, i|
#
#     provider = row[0]
#     country_name = row[1]
#     uni_name = row[2]
#     city_name = row[3]
#     course_code = row[4]
#     course_name = row[5]
#     language = row[6]
#     dept = row[7]
#     umd_course_name = row[8]
#     umd_course_code = row[9]
#     note = row[10]
#     lib_ed_cats = row[11]
#     lib_ed_cat_ids = row[12]
#     approved_name = row[13]
#     approved_date = row[14]
#     syllabus = row[15]
#
#     if provider == "provider_name"
#         next
#     end
#
#     if approved_date == "0000-00-00"
#         # UNIX epoch
#         approved_date = "1970-01-01"
#     end
#
#     begin
#
#         university = University.find_by_name_and_city_and_country(uni_name, city_name, country_name) || University.create(name: uni_name, city: city_name, country: country_name)
#
#         lib_eds = []
#         if(lib_ed_cats)
#             lib_eds = lib_ed_cats.split(';')
#         end
#
#         if syllabus && syllabus != ''
#             syl_file = File.new('import/syllabi/' + syllabus)
#             course = university.courses.create(code: course_code, name: course_name, language: language, syllabus: syl_file)
#         else
#             course = university.courses.create(code: course_code, name: course_name, language: language)
#         end
#
#         course = university.courses.create(code: course_code, name: course_name, language: language, syllabus: syl_file)
#
#         review = Equivalency.create(dept: dept, program_sponsor: provider, date_received: approved_date, course_id: course.id, status: :approved)
#
#         umd_course = UmdCourse.create(review_id: Equivalency.id, code: umd_course_code, name: umd_course_name, designator: dept, notes: note, lib_eds: lib_eds, approved: approved_date, approved_by: approved_name)
#
#
#     rescue Exception => e
#         puts e.inspect
#         #puts e.backtrace.join("\n")
#         puts 'row ' + (i+1).to_s + ': ' + row.join(' | ') + "\n"
#     end
# end