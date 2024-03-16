# frozen_string_literal: true

rspec.describe jekyll::importmaptag do
    let(:output) {
        liquid::template.parse("{% importmap %}").render
    }

    it 'renders' do
        expect(output).to eq("proof of concept")
    end

end