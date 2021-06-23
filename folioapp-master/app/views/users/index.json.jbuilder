json.array!(@users) do |user|
	json.name user.name
	json.id user.id
	json.profession user.formatted_profession
	json.network user.network
	json.shortBio user.short_bio
	json.signInCount user.sign_in_count
	json.userImage user.avatar.url




	json.collections(user.collections) do |collection|
		json.id collection.id
		json.title collection.title
		json.description collection.description
		json.image collection.image.url if collection.image.present?
		json.works(collection.works) do |work|
			json.title work.title
			json.format work.work_format
			json.image work.image.url
			json.genres do
				json.array! work.genre_names
			end
			json.media do
				json.array! work.medium_names
			end
			json.caption work.caption
			json.text work.text
		end
	end
end