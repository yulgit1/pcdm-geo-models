module GeoConcerns
  class ImageWorkShowPresenter < GeoConcernsShowPresenter
    self.work_presenter_class = ::GeoConcerns::ImageWorkShowPresenter
    self.file_format_service = ImageFormatService
  end
end
