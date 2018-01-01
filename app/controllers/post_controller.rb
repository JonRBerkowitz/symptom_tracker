class PostController < ApplicationController

  get '/posts' do
    if logged_in?

    @symptoms = Symptom.all
    @medications = Medication.all
    if params[:type => "symptom"]
      @type = "symptom"
    elsif params[:type => "medication"]
      @type = "medication"
    end
    erb :'/posts/new'
  else
    redirect '/login'
  end
  end

  post '/posts' do
    @user = current_user
    @post = Post.create

    @post.kind = params[:kind]
    name = params[:title].downcase

    if @post.kind == "symptom"

      if Symptom.find_by(:name => name)
        @symptom = Symptom.find_by(:name => name)
      else
        @symptom = Symptom.create(:name => name)
      end

      @post.title = @symptom.name
      @post.duration = "#{params[:duration][:length]} #{params[:duration][:unit]}"
      @post.intensity = params[:intensity]

      if !@user.symptoms.include?(@symptom)
        @user.symptoms << @symptom
      end

    elsif @post.kind == "medication"

      if Medication.find_by(:name => name)
        @medication = Medication.find_by(:name => name)
      else
        @medication = Medication.create(:name => name)
      end

      if !@user.medications.include?(@medication)
        @user.medications << @medication
      end
      @post.title = @medication.name
      @post.dose = "#{params[:dose]} mg"
    end
    @post.note = params[:note]
    @post.post_time = Time.now.strftime("%m/%d/%Y %H:%M")
    @user.posts << @post

    redirect "/users/#{@user.id}"
  end

  get '/posts/:id' do
    @symptoms = Symptom.all
    @medications = Medication.all
    @post = Post.find_by_id(params[:id])
    if current_user.posts.include?(@post)
      erb :'/posts/edit'
    else
      redirect '/'
    end
  end

  patch '/posts/:id/edit' do
    @user = current_user
    @post = Post.find_by_id(params[:id])

    if @user.posts.include?(@post)
      @post.title = params[:title]
      if @post.kind == "symptom"
        @post.duration = "#{params[:duration][:length]} #{params[:duration][:unit]}"
        @post.intensity = params[:intensity]
      elsif @post.kind == "medication"
        @post.dose = "#{params[:dose]} mg"
      end
      @post.note = params[:note]
      @post.save

      redirect "/users/#{@user.id}"
    else
      redirect '/'
    end
  end

  delete '/posts/:id/delete' do
    @user = current_user
    @post = Post.find_by_id(params[:id])
    if current_user.posts.include?(@post)
      @post.destroy
      redirect "/users/#{@user.id}"
    else
      redirect '/login'
    end
  end

end
