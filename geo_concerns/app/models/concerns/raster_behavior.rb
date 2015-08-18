module RasterBehavior
  extend ActiveSupport::Concern
  include ::CurationConcerns::GenericWorkBehavior
  include ::CurationConcerns::BasicMetadata
  include ::BasicGeoMetadata
  include ::GeoreferencedBehavior

  # associated_with :image (derived from, optional)

  included  do
    # property :resolution, Float
    # ...
  end
end
