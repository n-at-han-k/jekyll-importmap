# frozen_string_literal: true

RSpec.describe Jekyll::ImportmapTag do
    let(:output) {
        Liquid::Template.parse("{% importmap %}").render
    }

    it 'renders' do
        expect(output).to eq("proof of concept")
    end

end