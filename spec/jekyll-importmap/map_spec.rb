# frozen_string_literal: true

RSpec.describe Jekyll::Importmap::Map do
    subject(:importmap) {
        Jekyll::Importmap::Map.new.draw(TEST_IMPORTMAP_PATH)
    }
    let(:json_string) { importmap.to_json }
    let(:json_hash) { JSON.parse(json_string) }
    let(:expanded_packages) { importmap.send(:expanded_packages_and_directories) }

    it '.draw creates packages and directories' do
        importmap.packages.each do |package, path|
            expect(package.class.name).to eq('String')
            expect(path.class.name).to eq("Jekyll::Importmap::MappedFile")
        end
        importmap.directories.each do |package, path|
            expect(package.class.name).to eq('String')
            expect(path.class.name).to eq("Jekyll::Importmap::MappedDir")
        end
    end

    it '.pin creates a MappedFile' do
        importmap.packages.each do |package, path|
            expect(path.class.name).to eq("Jekyll::Importmap::MappedFile")
        end
    end

    it '.pin_all_from creates a MappedDir' do
        importmap.directories.each do |directory, path|
            expect(path.class.name).to eq("Jekyll::Importmap::MappedDir")
        end
    end

    it '.preloaded_module_paths' do
        expect(importmap.preloaded_module_paths.length).to eq(1)
    end

    it '.to_json' do
        expect(json_string.is_a?(String)).to eq(true)
        expect(json_hash.is_a?(Hash)).to eq(true)
        expect(json_hash.keys.length).to eq(1)
        expect(json_hash['imports'].is_a?(Hash)).to eq(true)
        expect(json_hash['imports'].length).to eq(3)
        #expect(json_hash).to eq(true)
        expect(json_hash['imports']['scrollable']).to eq(
            "https://127.0.0.1:4000/assets/vendor/scrollable.js"
        )
        expect(json_hash['imports']['test']).to eq(
            "https://127.0.0.1:4000/assets/js/index.js"
        )
        expect(json_hash['imports']['test/controller']).to eq(
            "https://127.0.0.1:4000/assets/js/controller.js"
        )
    end

    # PRIVATE methods

        it '.resolved_asset_paths' do
            importmap.send(:resolved_asset_paths).each do |name, path|
                expect(name.class.name).to eq('String')
                expect(path.class.name).to eq('String')
            end
        end

        it '.expanded_packages_and_directories turns all directories into packages' do
            expanded_packages.each do |package, path|
                expect(package.class.name).to eq('String')
                expect(path.class.name).to eq("Jekyll::Importmap::MappedFile")
            end
            expect(expanded_packages.values.length).to eq(3)
        end
end