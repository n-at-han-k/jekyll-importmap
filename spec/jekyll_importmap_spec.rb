# frozen_string_literal: true

RSpec.describe Jekyll::ImportmapTag do
    it 'renders' do
        expect(Jekyll::ImportmapTag.new('importmap', 'h', 'g').render(nil)).to eq(false)
    end
end