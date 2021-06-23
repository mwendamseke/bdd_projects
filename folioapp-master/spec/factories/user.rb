include ActionDispatch::TestProcess

FactoryGirl.define do
	factory :user do
		name 'Laurie Lewis'
		email 'hello@hi.com'
			password '12345678'
			password_confirmation '12345678'
		end

	factory :collection do
		title 'Paintings'
		description 'Stuff I gone done'
	end

	factory :work do 
		title 'Hello World'
		image { fixture_file_upload(Rails.root.join('features/images/art.jpg'), 'image/jpeg')}
	end

end