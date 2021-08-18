require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  describe '#index' do
    before do
      allow(BlogManager).to receive(:get_list).and_return([])
    end

    it 'gets the list of blogs and renders them' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe '#show' do
    before do
      allow(BlogManager).to receive(:get_blog).with('1').and_return({})
      allow(BlogManager).to receive(:get_comments).with('1').and_return([])
    end

    it 'gets the blog and its comments' do
      expect(BlogManager).to receive(:get_blog)
      expect(BlogManager).to receive(:get_comments)
      get :show, params: { id: 1 }
      expect(response.status).to eq(200)
    end
  end
end