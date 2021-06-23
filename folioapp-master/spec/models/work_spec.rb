require 'rails_helper'

RSpec.describe Work, :type => :model do
  let(:work) {Work.create}
	describe '#medium_names' do

		context 'with one medium that does not exist' do 
			it 'adds the medium to the work' do
				work.medium_names = "Painting"
				expect(work.media.length).to eq 1
			end
		end

		context 'with media that do not exist' do 
			it 'adds the media to the work' do
				work.medium_names = 'Painting, Watercolour'
				expect(work.media.length).to eq 2
			end
		end

		context 'with a medium that already exists' do 
			let!(:existing_medium) {Medium.create name: 'Painting'}

			it 'reuses the medium name' do 
				work.medium_names = 'Painting'
				expect(work.media).to include existing_medium
				expect(Medium.count).to eq 1
			end
		end

	end



	describe '#genre_names' do

		context 'with one genre that does not exist' do 
			it 'adds the genre to the work' do
				work.genre_names = "Cubism"
				expect(work.genres.length).to eq 1
			end
		end

		context 'with a genre that do not exist' do 
			it 'adds the genre to the work' do
				work.genre_names = 'Cubism, Scottish Futurism'
				expect(work.genres.length).to eq 2
			end
		end

		context 'with a genre that already exists' do 
			let!(:existing_genre) {Genre.create name: 'Cubism'}

			it 'reuses the medium name' do 
				work.genre_names = 'Cubism'
				expect(work.genres).to include existing_genre
				expect(Genre.count).to eq 1
			end
		end
	end

	describe 'validations' do 

		it 'errors out when no image is uploaded' do 
			work = Work.create(image: nil)
			expect(work).to have(1).error_on(:image)
		end

		it 'erros out when no title is given' do 
			work = Work.create(image: nil, title: nil)
			expect(work).to have(1).error_on(:title)
		end

	end





end
