require 'rails_helper'

RSpec.describe User, :type => :model do
  
	describe 'user#formatted_profession' do 

		let(:jamie) { User.create(email: "bla@bla.com", password: "12345678", password_confirmation: "12345678")}

		context 'with one profession given' do 
			it 'capitalizes the name' do 
				jamie.update(profession: 'writer')
				expect(jamie.formatted_profession).to eq 'Writer'
			end
		end

		context 'with multiple professions given' do 

			it 'between two words puts an ampersand between them' do 
				jamie.update(profession: 'writer, artist')
				expect(jamie.formatted_profession).to eq 'Writer & Artist'
			end

			it 'between three words puts an ampersand before the last word' do 
				jamie.update(profession: 'writer, artist, director')
				expect(jamie.formatted_profession).to eq 'Writer, Artist & Director'
			end

			it 'with four words' do 
				jamie.update(profession: 'writer, artist, director, sculptor') 
				expect(jamie.formatted_profession).to eq 'Writer, Artist, Director & Sculptor'
			end

		end

	end

end
