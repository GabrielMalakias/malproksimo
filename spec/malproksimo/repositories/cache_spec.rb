RSpec.describe Cache do
  describe 'SHORTEST_PATH_PREFIX' do

    subject {described_class::SHORTEST_PATH_PREFIX}

    it {is_expected.to eq('malproksimo:short_path')}
  end
end
