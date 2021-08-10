describe Api::ArticlesController, type: :request do
  let!(:articles) { create_list(:article, 50) }

  before do
    articles.each do |article|
      create_list(:comment, 3, article: article)
    end
  end

  let(:headers) do
    { "Accept" => "application/json" }
  end

  let(:fields) { '__default__' }

  describe 'GET /api/articles' do
    it 'returns articles' do
      get api_articles_path(fields: fields), headers: headers
      expect(response).to have_http_status(:ok)
      expect(response.body).to be_json_including(
        articles.first(20).map { |article|
          {
            id: article.id
          }
        }
      )
    end

    context 'with optional fields' do
      let(:fields) { '__default__,comments[__default__,user[__default__]]' }
      it 'returns articles' do
        get api_articles_path(fields: fields), headers: headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to be_json_including(
          articles.first(20).map { |article|
            {
              id: article.id
            }
          }
        )
      end
    end

    context 'with paginate params' do
      let(:page) { 2 }
      let(:per_page) { 10 }

      it 'returns paginated articles' do
        get api_articles_path(fields: fields, per_page: per_page, page: page), headers: headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to be_json_including(
          articles[(page-1) * per_page...page * per_page].map { |article|
            {
              id: article.id
            }
          }
        )
      end
    end
  end
end
