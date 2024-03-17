# frozen_string_literal: true

RSpec.describe Jekyll::Importmap::Resolver do
    let(:directory) {
        Jekyll::Importmap::MappedDir.new(
            dir: 'spec/test_js_files',
            under: 'vendor',
        )
    }

    it '.javascript_files_in_tree' do
        directory.javascript_files_in_tree.each do |file|
            expect(file.class.name).to eq("Pathname")
            expect(file.absolute?).to eq(true)
        end
    end

    it '.expanded_paths' do
        directory.expanded_paths.each do |path|
            expect(path.class.name).to eq("Jekyll::Importmap::MappedFile")
        end
    end

    it '.module_name_from' do
        #expect(true).to eq(false)
    end

    it '.module_path_from' do
        #expect(true).to eq(false)
    end
end