require 'rails_helper'

describe Article do
  it "should return max version_id using article_version_max" do
    @article = Article.create(
                          name: 'test',
                          body: 'text',
                          category_id: 1
    )
    version1 = Version.create(
        type_name: 'article',
        type_id: @article.id,
        content: [@article.name, @article.body, @article.category_id],
        version_id: 1
    )
    version2 = Version.create(
        type_name: 'article',
        type_id: @article.id,
        content: [@article.name, @article.body, @article.category_id],
        version_id: 2
    )
    version3 = Version.create(
        type_name: 'article',
        type_id: @article.id,
        content: [@article.name, @article.body, @article.category_id],
        version_id: 3
    )
    expect(@article.article_version_max).to eq 3
  end
end