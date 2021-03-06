require 'spec_helper'

describe GeoConcerns::ExternalMetadataFileForm do
  before do
    class TestModel < ActiveFedora::Base
    end

    class TestForm < CurationConcerns::Forms::WorkForm
      include GeoConcerns::ExternalMetadataFileForm
      self.model_class = TestModel
    end
  end

  after do
    Object.send(:remove_const, :TestForm)
    Object.send(:remove_const, :TestModel)
  end

  let(:object) { TestModel.new }
  let(:form) { TestForm.new(object, nil) }

  describe '.triggers' do
    it 'has should_populate_metadata trigger attribute' do
      expect(form.respond_to?(:should_populate_metadata)).to be_truthy
    end
  end
end
