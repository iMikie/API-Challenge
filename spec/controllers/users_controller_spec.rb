require 'spec_helper'

#make some users
#maybe make a known user
#make some keys

#test that user without key is rejected
#test listing users
#eventually test that user is given a key and can


describe 'users controller' do

  let: current_user do
    FactoryGirl.create :user
  end

  let :key do
    current_user.api_keys.create!.key
  end

  describe 'GET /v1/users' do

    before do
      10.times do
        FactoryGirl.create :user
      end
    end

  #authentication
  context 'no api key provided' do
    it 'should return unauthorized' do
      get '/v1/users'
      expect(last_response.status).to eq 401
      expect(last_response.body).to eq 'Unauthorized'
    end
  end

  context 'wrong key provided' do
    it 'should return unauthorized' do
      get /'v1/users', key: '123345987'
      expect(last_response.status).to eq 401
      expect(last_response.body).to eq 'Unauthorized'
    end
  end

  context 'user is authenticated' do #authenticated later
    it 'should render all users' do
      get '/v1/users', key: key
      expect(last_response.status).to eq 200
      expect(last_response.content_type).to start_with 'application/json'
      users = JSON.parse(last_response.body)
      expect(users).to be_an Array
      expect(users.length).to eq 11
      expect(users.first).to eq User.first.as_json
    end
  end
end


