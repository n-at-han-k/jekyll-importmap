# frozen_string_literal: true

RSpec.describe Jekyll::Importmap::Resolver do
    let(:resolver) { Jekyll::Importmap::Resolver }
    let(:url_with_port) { '127.0.0.1:4000' }

    it '#path_to_asset' do
        expect(resolver.path_to_asset('test_file')).to eq('https://127.0.0.1:4000/test_file')
    end

    it '#url' do
        expect(resolver.url).to eq(url_with_port)
    end
end