require 'pry'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/articles" do
    article = Article.all
    article.to_json
  end

  get "/pictures" do
    pics = Picture.all
    pics.to_json
  end

  post "/pictures" do
    newPicture = Picture.create(
      name: params[:name],
      image_url: params[:image_url],
      article_id: params[:article_id]
    )
  end

  get "/articles_basics" do
    article = Article.all
    # article.to_json(only: [:id, :title, :description, :article_text], include: [:author])
    article.to_json(only: [:id, :title, :description, :article_text,], include:  { author:{only: [:id, :first_name, :last_name], include: {categories: {only: [:name, :id]}}}, pictures: {only: [:image_url, :name]}})
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

    picture = Picture.create(
      name: params[:picture_name],
      image_url: params[:picture],
      article_id: new_article.id
    )

    new_article.to_json(only: [:id, :title, :description, :article_text,], include:  { author:{only: [:id, :first_name, :last_name], include: {categories: {only: [:name, :id]}}}, pictures: {only: [:image_url, :name]}})
  end

  patch "/articles/:id" do
    updated = Article.find(params[:id])
      title = params[:title] ? params[:title] : updated.title
      des = params[:description] ? params[:description] : updated.description
      art = params[:article_text] ? params[:article_text] : updated.article_text
      updated.update(
      title: title,
      description: des,
      article_text: art
    )

    # Picture.delete_all

    # picture = Picture.create(
    #   name: params[:picture_name],
    #   image_url: params[:picture],
    #   article_id: params[:id]
    # )
    # binding.pry
    updated.to_json(only: [:id, :title, :description, :article_text,], include:  { author:{only: [:id, :first_name, :last_name], include: {categories: {only: [:name, :id]}}}, pictures: {only: [:image_url, :name]}})
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
