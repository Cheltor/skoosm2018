json.extract! course, :id, :name, :subject_id, :university_id, :created_at, :updated_at
json.url course_url(course, format: :json)