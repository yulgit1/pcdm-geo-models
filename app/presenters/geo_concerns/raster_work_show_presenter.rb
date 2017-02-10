module GeoConcerns
  class RasterWorkShowPresenter < GeoConcernsShowPresenter
    self.work_presenter_class = ::GeoConcerns::RasterWorkShowPresenter
    self.file_format_service = GeoConcerns::RasterFormatService
  end
end
