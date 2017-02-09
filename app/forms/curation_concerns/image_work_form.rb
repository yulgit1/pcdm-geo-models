module CurationConcerns
  class ImageWorkForm < CurationConcerns::Forms::WorkForm
    include ::GeoConcerns::BasicGeoMetadataForm
    include ::GeoConcerns::ExternalMetadataFileForm
    include ::GeoConcerns::OidMetadataFileForm
    self.model_class = ::ImageWork
  end
end
