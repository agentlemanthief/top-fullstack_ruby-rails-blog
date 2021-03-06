# Frozen_string_literal: true

# Controller describing actions for Article
class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'nicholas', password: 'oldlongjohnson', only: :destroy

  def index
    @articles = Article.all.order('updated_at desc')
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:post_success] = 'Thank you for your post!'
      redirect_to @article
    else
      flash[:post_failure] = 'Your post could not be saved!'
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
