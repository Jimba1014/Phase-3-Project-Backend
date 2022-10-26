class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/articles" do
    article = Article.all
    article.to_json
  end

  post "/articles" do
    new_article = Article.create(
      title: params[:title],
      description: params[:description],
      article_text: params[:article_text],
      author_id: params[:aurthor_id],
      categroy_id: params[:category_id]
    )
    new_article.to_json
  end

  patch "/articles/:id" do
    updated = Article.find(params[:id])
    updated.update(
      title: params[:title],
      description: params[:description],
      article_text: params[:article_text]
    )
  end

  get "/articles_basics" do
    article = Article.all
    article.to_json(only: [:id, :title, :description], include: [:author] )
  end

  get '/articles/:id' do
    article = Article.find(params[:id])
    article.to_json(include: :author)
  end

  delete '/articles/:id' do
    article = Article.find(params[:id])
    article.destroy
    article.to_json
  end
end
