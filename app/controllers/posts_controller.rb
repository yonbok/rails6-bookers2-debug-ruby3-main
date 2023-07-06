class PostsController < ApplicationController

  @posts = Post.includes(:favorited_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}

end
