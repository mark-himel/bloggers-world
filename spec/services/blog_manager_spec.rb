require 'rails_helper'

RSpec.describe BlogManager, type: :model do
  before do
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:[]).with('BLOG_SERVER_BASE_URL').and_return('http://127.0.0.1:4000')
  end

  describe '.get_list' do
    let(:result) do
      VCR.use_cassette 'blog_manager/get_list' do
        described_class.get_list
      end
    end
    it 'retrieves all available blogs from the server' do
      expect(result).to be_a Array
      expect(result.length).to eq(6)
    end
  end

  describe '.get_blog' do
    let(:valid_id) { 1 }
    let(:invalid_id) { 100 }

    let(:valid_result) do
      VCR.use_cassette 'blog_manager/get_blog/valid' do
        described_class.get_blog(valid_id)
      end
    end

    let(:invalid_result) do
      VCR.use_cassette 'blog_manager/get_blog/invalid' do
        described_class.get_blog(invalid_id)
      end
    end

    context 'when request with valid id' do
      it 'successfully retrieves the blog' do
        expect(valid_result['id']).to eq(1)
        expect(valid_result['title']).to eq('The Great Title')
      end
    end

    context 'when request with invalid id' do
      it 'fails to retrieve' do
        expect(invalid_result).to eq(nil)
      end
    end
  end

  describe '.get_comments' do
    let(:valid_id) { 1 }
    let(:invalid_id) { 100 }

    let(:valid_result) do
      VCR.use_cassette 'blog_manager/get_comments/valid' do
        described_class.get_comments(valid_id)
      end
    end

    let(:invalid_result) do
      VCR.use_cassette 'blog_manager/get_comments/invalid' do
        described_class.get_comments(invalid_id)
      end
    end

    context 'when request with valid id' do
      it 'successfully retrieves the comments for the blog' do
        expect(valid_result.length).to eq(6)
      end
    end

    context 'when request with invalid id' do
      it 'fails to retrieve' do
        expect(invalid_result).to eq([])
      end
    end
  end

  describe '.post_comment' do
    let(:valid_id) { 1 }
    let(:valid_params) do
      {
        name: 'Rspec',
        body: 'This comment is from rspec',
        post_id: 1
      }
    end
    let(:invalid_params) do
      {
        body: 'This comment is from rspec that will fail to create',
        post_id: 1
      }
    end

    let(:valid_result) do
      VCR.use_cassette 'blog_manager/post_comment/valid' do
        described_class.post_comment(valid_id, valid_params)
      end
    end

    let(:invalid_result) do
      VCR.use_cassette 'blog_manager/post_comment/invalid' do
        described_class.post_comment(valid_id, invalid_params)
      end
    end

    context 'when request params are valid' do
      it 'succeeds to post the comment under the blog' do
        expect(valid_result['comment']['id']).to eq(26)
        expect(valid_result['comment']['post_id']).to eq(1)
        expect(valid_result['errors']).to eq(nil)
      end
    end

    context 'when request params are invalid' do
      it 'fails to post the comment under the blog' do
        expect(invalid_result['comment']['id']).to eq(nil)
        expect(invalid_result['errors']).not_to be_empty
      end
    end
  end

  describe '.post_blog' do
    let(:valid_params) do
      {
        title: 'Rspec',
        body: 'This comment is from rspec',
      }
    end
    let(:invalid_params) do
      {
        body: 'This comment is from rspec that will fail to create'
      }
    end

    let(:valid_result) do
      VCR.use_cassette 'blog_manager/post_blog/valid' do
        described_class.post_blog(valid_params)
      end
    end

    let(:invalid_result) do
      VCR.use_cassette 'blog_manager/post_blog/invalid' do
        described_class.post_blog(invalid_params)
      end
    end

    context 'when request params are valid' do
      it 'succeeds to post the blog' do
        expect(valid_result['post']['id']).to eq(7)
        expect(valid_result['errors']).to eq(nil)
      end
    end

    context 'when request params are invalid' do
      it 'fails to post the blog' do
        expect(invalid_result['post']['id']).to eq(nil)
        expect(invalid_result['errors']).not_to be_empty
      end
    end
  end
end
