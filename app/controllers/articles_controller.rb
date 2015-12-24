class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :history, :his_detail, :back_version]

  def index
    @articles = Article.all
  end

  def show
  end

  def history
    @versions = @article.versions.order('created_at DESC')
  end

  def his_detail
    @his_article = Version.find_by_id(params[:version]).content
  end

  def back_version
    @his_article = Version.find_by_id(params[:version]).content
    @article.name = @his_article[0]
    @article.body = @his_article[1]
    @article.category_id = @his_article[2]
    if @article.save
      version = Version.new(
          type_name: 'article',
          type_id: @article.id,
          content: [@article.name, @article.body, @article.category_id],
          version_id: @article.article_version_max + 1
      )
      version.save
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
    # @article.category_id = params[:category_id].first.to_i

    respond_to do |format|
      if @article.save
        version = Version.new(
                             type_name: 'article',
                             type_id: @article.id,
                             content: [@article.name, @article.body, @article.category_id],
                             version_id: 1
        )
        version.save
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
        version = Version.new(
            type_name: 'article',
            type_id: @article.id,
            content: [@article.name, @article.body, @article.category_id],
            version_id: @article.article_version_max + 1
        )
        version.save
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
