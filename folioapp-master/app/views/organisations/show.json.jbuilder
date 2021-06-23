json.name @organisation.name
json.id @organisation.id
json.organisationType @organisation.organisation_type
json.network @organisation.network
json.description @organisation.description
json.image @organisation.image.url if @organisation.image.present?

json.opportunities(@organisation.opportunities) do |opportunity|
	json.title opportunity.title
	json.id opportunity.id
	json.description opportunity.description
	json.requirements opportunity.requirements
	json.image opportunity.image.url if opportunity.image.present?
end