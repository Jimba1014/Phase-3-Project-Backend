class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/articles" do
    article = Article.all
    article.to_json
  end

  get "/articles_basics" do
    article = Article.all
    # article.to_json(only: [:id, :title, :description, :article_text], include: [:author])
    article.to_json(only: [:id, :title, :description, :article_text,], include:  { author:{only: [:id, :first_name, :last_name], include: {categories: {only: [:name]}}}, pictures: {only: [:image_url, :name]}})
  end

  post "/articles" do
    category = Category.find_by(id: params[:category])
    author = Author.find_by(first_name: params[:first_name], last_name: params[:last_name])

    if author == nil 
      print("Creating author...")
      author = Author.create(first_name: params[:first_name], last_name: params[:last_name])
    end

    print(params)

    new_article = Article.create(
      title: params[:title],
      description: params[:description],
      article_text: params[:article_text],
      author: author,
      category: category
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
