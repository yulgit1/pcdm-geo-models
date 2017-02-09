module GeoConcerns
  module MetadataExtractionHelper
    # Extracts properties from the constitutent external metadata file
    # @return [Hash]
    def extract_metadata(id)
      return {} if metadata_files.blank?
      metadata_file = metadata_files.find { |f| f.id == id }
      metadata_file.extract_metadata if metadata_file
    end

    # Sets properties from the constitutent external metadata file
    def populate_metadata(id)
      extract_metadata(id).each do |k, v|
        send("#{k}=".to_sym, v) # set each property
      end
    end

    attr_accessor :should_populate_metadata

    def should_populate_metadata=(args)
      @should_populate_metadata = args.present? && args != ''
      return unless should_populate_metadata
      populate_metadata(args)
      save
    end

    attr_accessor :should_populate_from_oid

    def should_populate_from_oid=(args)
      @should_populate_from_oid = args.present? && args != ''
      return unless should_populate_from_oid
      Rails.logger.info "TEST:#{args.inspect}"
    end
end

end
