require 'rails_helper'

# Gram Controller Specs
RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  # New Action Tests
  describe "grams#new action" do
    
    #Logged in test
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    # New form test
    it "should successfully show the new form" do
      user = FactoryBot.create(:user)
      sign_in user
      
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  # Create Action Tests
  describe "grams#create action" do
    
    # Logged in test
    it "should require users to be logged in" do
      post :create, params: { gram: { message: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end

    # Create new gram test
    it "should successfully create a new gram in our database" do
  		user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { gram: { message: 'Hello!' } }
  		expect(response).to redirect_to root_path

  		gram = Gram.last
  		expect(gram.message).to eq("Hello!")
      expect(gram.user).to eq(user)
  	end
    
    # Validation test
    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      gram_count = Gram.count
      post :create, params: { gram: { message: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(gram_count).to eq Gram.count
    end
  
  end

end