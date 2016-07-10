require 'spec_helper'
require 'action_controller/test_case'

class MetaTagsController < ActionController::Base
  def index
    @page_title       = 'title'
    @page_keywords    = 'key1, key2, key3'
    @page_description = 'description'

    render plain: ''
  end

  private

  public :set_meta_tags, :meta_tags
end

describe MetaTags::ControllerHelper do
  subject(:controller) { MetaTagsController.new }

  context 'module' do
    it 'should be mixed into ActionController::Base' do
      expect(ActionController::Base.included_modules).to include(MetaTags::ControllerHelper)
    end

    it 'should respond to "set_meta_tags" helper' do
      is_expected.to respond_to(:set_meta_tags)
    end
  end

  describe '.render' do
    let(:session) { ActionController::TestSession.new }
    let(:env) { {} }
    let(:request) { ActionController::TestRequest.new(env, session) }
    let(:response) { ActionDispatch::Response.create }

    before do
      controller.request = request
      controller.response = response
      subject.index
    end

    it 'should set meta tags from instance variables' do
      expect(response).to be_ok
      expect(response.body).to eq('')
      expect(subject.meta_tags.meta_tags).to eq('title' => 'title', 'keywords' => 'key1, key2, key3', 'description' => 'description')
    end
  end

  it_behaves_like '.set_meta_tags'
end
