module CurationConcerns
  class VectorWorkForm < CurationConcerns::Forms::WorkForm
    include ::GeoConcerns::BasicGeoMetadataForm
    include ::GeoConcerns::GeoreferencedForm
    include ::GeoConcerns::ExternalMetadataFileForm
    include ::GeoConcerns::OidMetadataFileForm
    self.model_class = ::VectorWork
  end
end
