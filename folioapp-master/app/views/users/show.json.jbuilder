json.name @user.name
json.id @user.id
json.userImage @user.avatar.url
json.profession @user.formatted_profession
json.userImage @user.avatar.url
json.network @user.network
json.shortBio @user.short_bio
json.signInCount @user.sign_in_count

if !@user.work_selection.nil? 
	json.workSelection(@user.work_selection.works[0..2]) do |work|
			json.id work.id
			json.collection work.collection.title
			json.collectionId work.collection.id
			json.indexInCollection work.collection.works.index(work)
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
	end
	json.memberships(@user.memberships) do |membership|
		json.organisation membership.organisation.name
		json.organisationId membership.organisation.id
		json.organisationRole membership.role
	end
end

json.collections(@user.collections) do |collection|
	json.id collection.id
	json.title collection.title
	json.description collection.description
	json.image collection.image.url if collection.image.present?
	json.works(collection.works) do |work|
		json.id work.id
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

