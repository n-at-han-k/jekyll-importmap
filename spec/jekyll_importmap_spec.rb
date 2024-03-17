# frozen_string_literal: true

RSpec.describe Jekyll::ImportmapTag do
    let(:output) {
        Liquid::Template.parse("{% importmap %}").render
    }

    it 'renders' do
        #expect(Jekyll.configuration).to eq("proof of concept")
        #expect(output).to eq("proof of concept")
    end
end