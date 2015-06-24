
#List articles

get '/v1/articles' do
  ensure_authenticated!
  content_type :json
  Articles.all.to_json
end

#List articles belonging to a user
get '/v1/users/:user_id/articles' do
  user = User.find(params['user_id'])
  content_type :json
  user.articles.all.to_json
end

#Create new article
post '/v1/users/:user_id/articles' do
  ensure_authenticated!
  content_type :json
  article = User.find(params['user_id']).articles.new(title: params[:title], body: params[:body])
  if !article.save
    status 500
  else
    status 202
    article.to_json
  end
end

#list comments for an article
get '/v1/articles/:article_id/comments/' do
  (Article.find(params['article_id'])).comments.all
  status 200
end

#list comments belonging to a user
get '/v1/users/:user_id/comments' do
  (User.find(params['user_id'])).comments.all
end

#Create a new comment (for an article by a user)
#post '/v1/users/:user_id/articles/:article_id/comments' do
post '/v1/articles/:article_id/comments' do
  #user = User.find(params['user_id'])
  #art = user.articles.find(params['article_id'])
  art = articles.find(params['article_id'])
  comment = art.comments.new(body: params[:body], user_id: params[:user_id])
  if !comment.save
    status 500
  else
    status 202
    comment.to_json
  end
end



