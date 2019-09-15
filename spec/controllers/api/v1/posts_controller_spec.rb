require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller, oauth: true do
  
  let(:application) { create :application }
  let(:user_account_access) { create :user_account_access }
  let(:user) { user_account_access.user }
  let(:account) { user_account_access.account }
  let(:access_token) { create :access_token, application: application, resource_owner_id: user.id }
  let(:valid_attributes) {
    {"attributes"=>{"title"=>"Post", "body"=>"Post", "tag_list"=>["hi", "bye"],"user_id"=> user.id,"account_id"=> account.id}, "type"=>"posts"}
  }

  describe "GET #index" do
    it "returns a success response" do
      post = Post.create! valid_attributes["attributes"]
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns success" do
      post = Post.create! valid_attributes["attributes"]
      get :show,params: {id: post.slug}
      expect(response).to be_success
    end
    it "visit count increases" do
      post = Post.create! valid_attributes["attributes"]
      get :show,params: {id: post.slug}
      views = Post.friendly.find(post.slug).views
      expect(views).to eq(1)
    end
  end

  describe "POST #create" do
    it "return success" do
      post :create, params:{:data => valid_attributes,access_token: access_token.token}, :format => :json
      expect(response).to be_success
    end

    context "post without title" do
      let(:invalid_attributes){ {"attributes"=>{"title"=>"", "body"=>"Post", "tag_list"=>["hi", "bye"]}, "type"=>"posts"}}
      it "empty title" do
        post :create, params:{:data => invalid_attributes,access_token: access_token.token}, :format => :json
        expect(response.status).to eq 422 
      end
    end

    context "post without body" do
      let(:invalid_attributes){{"attributes"=>{"title"=>"title", "tag_list"=>["hi", "bye"]}, "type"=>"posts"}}
      it "empty title" do
        post :create, params:{:data => invalid_attributes,access_token: access_token.token}, :format => :json
        expect(response.status).to eq 422 
      end
    end

  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{"attributes"=>{"title"=>"new title", "body"=>"new body", "tag_list"=>["bye"]}, "type"=>"posts"}}
      it "update the post" do
        post = Post.create! valid_attributes["attributes"]
        put :update, params: {id: post.slug,data:  new_attributes,access_token: access_token.token},:format => :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid params" do
      it "update the post" do
        post = Post.create! valid_attributes["attributes"]
        expect {
          delete :destroy, params: {id: post.slug,access_token: access_token.token}
        }.to change(Post, :count).by(-1)
      end
    end
  end

end
