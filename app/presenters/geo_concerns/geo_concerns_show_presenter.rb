module GeoConcerns
  class GeoConcernsShowPresenter < CurationConcerns::WorkShowPresenter
    delegate :spatial, :temporal, :issued, :coverage, :provenance, :layer_modified,
             :identifier, to: :solr_document
    class_attribute :file_format_service, :work_presenter_class

    def geo_file_set_presenters
      # filter for geo file sets
      file_set_presenters.select do |member|
        file_format_service.include? member.solr_document[:geo_mime_type_tesim][0]
      end
    end

    def external_metadata_file_set_presenters
      # filter for external metadata files
      file_set_presenters.select do |member|
        MetadataFormatService.include? member.solr_document[:geo_mime_type_tesim][0]
      end
    end

    def parent_work_presenters
      # filter out collection presenters
      member_of_presenters.select do |member|
        member.model_name.name != "Collection"
      end
    end

    def member_of_presenters
      CurationConcerns::PresenterFactory.build_presenters(member_of_ids,
                                                          collection_presenter_class,
                                                          *presenter_factory_arguments)
    end

    def member_of_ids
      ActiveFedora::SolrService.query("{!field f=member_ids_ssim}#{id}",
                                      fl: ActiveFedora.id_field)
                               .map { |x| x.fetch(ActiveFedora.id_field) }
    end

    def attribute_to_html(field, options = {})
      if field == :coverage
        GeoConcerns::CoverageRenderer.new(field, send(field), options).render
      else
        super field, options
      end
    end
  end
end
