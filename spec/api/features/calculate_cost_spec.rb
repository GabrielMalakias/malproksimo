require 'features_helper'


describe 'Calculate costs', type: :controller do
  let(:repository) { EdgeRepository.new }

  before do
    repository.clear

    repository.create(source: 'A', destination: 'B', length: 10)
    repository.create(source: 'B', destination: 'C', length: 15)
    repository.create(source: 'A', destination: 'C', length: 30)
  end

  it 'must be equals 18.75' do
    visit '/api/cost?origin=A&destination=C&weight=5'

    expect(page.body).to eq "18.75"
  end
end

