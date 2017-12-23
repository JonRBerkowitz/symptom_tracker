class PostController < ApplicationController

  get '/posts' do
    @symptoms = Symptom.all
    if params[:type => "symptom"]
      @type = "symptom"
    elsif params[:type => "medication"]
      @type = "medication"
    end
    erb :'/posts/new'
  end

  post '/posts' do
    @user = current_user
    @post = Post.create(:title => params[:symptom])
    @post.type = params[:type]
    @post.duration = "#{params[:duration][:length]} #{params[:duration][:unit]}"
    @post.intensity = params[:intensity]
    @post.note = params[:note]
    @post.post_time = Time.now.strftime("%d/%m/%Y %H:%M")
    @user.posts << @post
    redirect "/users/#{@user.id}"
  end

end
