# frozen_string_literal: true

RSpec.describe Jekyll::Importmap::MappedFile do
    let(:file) {
        Jekyll::Importmap::MappedFile.new(
            name: 'test_file'
        )
    }

    it '.name' do
        expect(file.name).to eq('test_file')
    end
end