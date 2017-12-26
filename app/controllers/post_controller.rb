class PostController < ApplicationController

  get '/posts' do
    @symptoms = Symptom.all
    @medications = Medication.all
    if params[:type => "symptom"]
      @type = "symptom"
    elsif params[:type => "medication"]
      @type = "medication"
    end
    erb :'/posts/new'
  end

  post '/posts' do
    @user = current_user
    @post = Post.create(:title => params[:title])

    @post.kind = params[:kind]

    if @post.kind == "symptom"


      if Symptom.find_by(:name => params[:title])
        @symptom = Symptom.find_by(:name => params[:title])
      else
        @symptom = Symptom.create(:name => params[:title])
      end

      @post.duration = "#{params[:duration][:length]} #{params[:duration][:unit]}"
      @post.intensity = params[:intensity]

      if !@user.symptoms.include?(@symptom)
        @user.symptoms << @symptom
      end

    elsif @post.kind == "medication"

      if Medication.find_by(:name => params[:title])
        @medications = Medication.find_by(:name => params[:title])
      else
        @medications = Medication.create(:name => params[:title])
      end

      if !@user.medications.include?(@medications)
        @user.medications << @medications
      end

      @post.dose = "#{params[:dose]} mg"
    end
    @post.note = params[:note]
    @post.post_time = Time.now.strftime("%d/%m/%Y %H:%M")
    @user.posts << @post

    redirect "/users/#{@user.id}"
  end

  get '/posts/:id' do
    @symptoms = Symptom.all
    @medications = Medication.all
    @post = Post.find_by_id(params[:id])
    erb :'/posts/edit'
  end

  patch '/posts/:id/edit' do
    @user = current_user
    @post = Post.find_by_id(params[:id])
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
  end

  delete '/posts/:id/delete' do
    @user = current_user
    @post = Post.find_by_id(params[:id])
    @post.destroy

    redirect "/users/#{@user.id}"
  end

end
