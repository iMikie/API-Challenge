#users_controllers.rb
#List users

#List users
get '/v1/users' do
  ensure_authenticated!
  status 200
  content_type :json
  User.all.to_json
end

#provide a key for a user
post '/v1/login' do
    user = User.where(username: params[:username], email: params[:email]).first
    if user
      user.key = Key.create_key!
      user.update_attributes(:key)

      if !user.save
        halt(500, 'Some Error')
        user.to_json(methods: [:errors])
      #user.errors.to_json
      else
        status 200
      # user.to_json(key: user.key)
        {key: user.key}.to_json
    end
  end
end
