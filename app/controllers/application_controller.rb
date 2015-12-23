class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def add_content_to_file(model,content,id)
    repo = Rugged::Repository.new("version_repo/#{model}")
    oid = repo.write(content, :blob)
    index = repo.index
    index.read_tree(repo.head.target.tree)
    index.add(:path => "#{id}", :oid => oid, :mode => 0100644)

    options = {}
    options[:tree] = index.write_tree(repo)

    options[:author] = { :email => "kaixuanguiqu@gmail.com", :name => 'Zoker', :time => Time.now }
    options[:committer] = { :email => "kaixuanguiqu@gmail.com", :name => 'Zoker', :time => Time.now }
    options[:message] ||= "Commit For #{model} - ID:#{id}"
    options[:parents] = repo.empty? ? [] : [ repo.head.target ].compact
    options[:update_ref] = 'HEAD'

    test = Rugged::Commit.create(repo, options)
    Rails.logger.error test
  end
end
