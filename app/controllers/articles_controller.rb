class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :his_detail, :back_version]

  def index
    @articles = Article.all
  end

  def show
  end

  def history
    @article = Article.find params[:id]
  end

  def his_detail
    repo = Rugged::Repository.new("version_repo/article")
    commit = repo.lookup(params[:version])
    blob = repo.lookup(commit.tree["#{params[:id]}"][:oid])
    @his_article = Marshal.load blob.content
  end

  def back_version
    repo = Rugged::Repository.new("version_repo/article")
    commit = repo.lookup(params[:version])
    blob = repo.lookup(commit.tree["#{params[:id]}"][:oid])
    @his_article = Marshal.load blob.content
    @article.name = @his_article[0]
    @article.body = @his_article[1]
    @article.category_id = @his_article[2]
    if @article.save
      redirect_to @article, notice: '恢复成功!'
    end
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save

        content = Marshal.dump([@article.name, @article.body, @article.category_id])
        version = add_content_to_file('article',content,@article.id)
        @article.version.push(version)
        @article.save

        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)

        content = Marshal.dump([@article.name, @article.body, @article.category_id])
        version = add_content_to_file('article',content,@article.id)
        @article.version.push(version)
        @article.save

        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:name, :body, :category_id)
  end

end
