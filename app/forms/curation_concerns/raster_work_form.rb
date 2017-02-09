module CurationConcerns
  class RasterWorkForm < CurationConcerns::Forms::WorkForm
    include ::GeoConcerns::BasicGeoMetadataForm
    include ::GeoConcerns::GeoreferencedForm
    include ::GeoConcerns::ExternalMetadataFileForm
    include ::GeoConcerns::OidMetadataFileForm
    self.model_class = ::RasterWork
  end
end
