require 'spec_helper'

describe GeoFileFormatBehavior do
  subject { FileSet.new }

  describe '#image_file?' do
    before do
      allow(subject).to receive(:geo_file_format).and_return('TIFF')
    end
    it 'is true' do
      expect(subject.image_file?).to be true
    end
  end

  describe '#raster_file?' do
    before do
      allow(subject).to receive(:geo_file_format).and_return('TIFF_GeoTIFF')
    end
    it 'is true' do
      expect(subject.raster_file?).to be true
    end
  end

  describe '#vector_file?' do
    before do
      allow(subject).to receive(:geo_file_format).and_return('SHAPEFILE')
    end
    it 'is true' do
      expect(subject.vector_file?).to be true
    end
  end

  describe '#external_metadata_file?' do
    before do
      allow(subject).to receive(:geo_file_format).and_return('ISO19139')
    end
    it 'is true' do
      expect(subject.external_metadata_file?).to be true
    end
  end

  describe '#image_file_formats' do
    it 'returns array of image formats' do
      expect(subject.class.image_file_formats).to eq(['TIFF', 'IMAGE_FILE'])
    end
  end

  describe '#raster_file_formats' do
    it 'returns array of raster formats' do
      expect(subject.class.raster_file_formats).to eq(['TIFF_GeoTIFF', 'RASTER_FILE'])
    end
  end

  describe '#vector_file_formats' do
    it 'returns array of vector formats' do
      expect(subject.class.vector_file_formats).to eq(['SHAPEFILE', 'SHAPEFILE_ZIP', 'VECTOR_FILE'])
    end
  end

  describe '#external_metadata_file_formats' do
    it 'returns array of external metadata file formats formats' do
      expect(subject.class.external_metadata_file_formats).to eq(['FGDC', 'ISO19139', 'MODS', 'EXTERNAL_METADATA_FILE'])
    end
  end
end
