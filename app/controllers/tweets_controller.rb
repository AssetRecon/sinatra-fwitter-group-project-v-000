class TweetsController < ApplicationController

 get '/tweets' do
   if logged_in?
     erb :'/tweets/tweets'
   else
     redirect to '/login'
   end
 end

 get '/tweets/new' do
   if logged_in?
     erb :'/tweets/new'
   else
     redirect to '/login'
   end
 end

get '/tweets/:id' do
  if logged_in?
  @tweet = Tweet.find_by_id(params[:id])
  erb :'tweets/show_tweet'
else
  redirect to '/login'
end
end

get '/tweets/:id/edit' do
  if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit_tweet'
  else
    redirect to '/login'
  end
end

 post '/tweets' do
   if logged_in?
     if params[:content] == ""
       redirect to '/tweets/new'
     else
       @tweet = Tweet.new
       @tweet.content = params[:content]
       @tweet.user_id = current_user.id
       @tweet.save
     end
   else
     redirect to '/login'
   end
 end

patch '/tweets/:id' do
  if logged_in?
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{tweet.id}"
    end
  else
    redirect to '/login'
  end

end

end
