require 'spec_helper'

describe ImagesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'remove'" do
    it "returns http success" do
      get 'remove'
      response.should be_success
    end
  end

end
