module GeoConcerns
  module OidMetadataFileForm
    extend ActiveSupport::Concern
    included do
      self.terms += [:should_populate_from_oid]
    end
  end
end