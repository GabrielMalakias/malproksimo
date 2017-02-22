require_relative '../../../../apps/api/controllers/cost/index'

RSpec.describe Api::Controllers::Cost::Index do
  let(:action) { described_class.new }
  let(:repository) { EdgeRepository.new }
  let(:params) do
    {origin: 'A', destination: 'B',  weight: 50}
  end

  context 'when invalid' do
    let(:params) do
      {origin: 'A', destination: 'B', weight: 0}
    end

    context 'bottom limit' do

      it 'returns precondition failed' do
        response = action.call(params)

        expect(response[0]).to eq 412
        expect(response[2]).to eq ["Weight must be one of: 1 - 51"]
      end
    end

    context 'top limit' do
      let(:params) do
        {origin: 'A', destination: 'B', weight: 51}
      end

      it 'returns precondition failed' do
        response = action.call(params)

        expect(response[0]).to eq 412
        expect(response[2]).to eq ["Weight must be one of: 1 - 51"]
      end
    end
  end

  context 'when valid' do
    before do
      repository.clear

      repository.create(source: 'A', destination: 'B', length: 10)
      repository.create(source: 'B', destination: 'C', length: 15)
      repository.create(source: 'A', destination: 'C', length: 30)
    end

    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq 200
      expect(response[2]).to eq [75]
    end
  end
end
