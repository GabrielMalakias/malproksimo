require_relative '../../../../apps/api/controllers/edges/create'

RSpec.describe Api::Controllers::Edges::Create do
  let(:action) { described_class.new }
  let(:params) do
    {source: 'A', destination: 'B', length: 100000}
  end

  context 'when invalid' do
    let(:params) do
      {source: 'A', destination: 'B', length: 0}
    end

    context 'bottom limit' do
      let(:params) do
        {source: 'A', destination: 'B', length: 0}
      end

      it 'returns precondition failed' do
        response = action.call(params)

        expect(response[0]).to eq 412
        expect(response[2]).to eq ["Length must be one of: 1 - 100001"]
      end
    end

    context 'top limit' do
      let(:params) do
        {source: 'A', destination: 'B', length: 100001}
      end

      it 'returns precondition failed' do
        response = action.call(params)

        expect(response[0]).to eq 412
        expect(response[2]).to eq ["Length must be one of: 1 - 100001"]
      end
    end

  end

  context 'when valid' do
    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq 200
      expect(response[2]).to eq ["Created or Updated"]
    end
  end
end
