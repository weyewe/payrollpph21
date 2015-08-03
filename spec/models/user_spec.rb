require 'rails_helper'

RSpec.describe User, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with all field required" do
    username = "user01"
    user = User.create_object(
        :office_id => @office.id,
        :username => username,
        :password => "user",
        :name => "User 01"
      )
      
    user.should be_valid
    
    user.username.should == username
  end
  
  it "should not allow object creation without office id" do
    username = "user01"
    user = User.create_object( 
        :office_id => "",
        :username => username,
        :password => "user",
        :name => "User 01"
      )
      
    user.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    username = "user01"
    user = User.create_object( 
        :office_id => 0,
        :username => username,
        :password => "user",
        :name => "User 01"
      )
      
    user.should_not be_valid
  end
  
  it "should not allow object creation without username" do
    username = "user01"
    user = User.create_object( 
        :office_id => @office.id,
        :username => "",
        :password => "user",
        :name => "User 01"
      )
      
    user.should_not be_valid
  end
  
  it "should not allow object creation without password" do
    username = "user01"
    user = User.create_object( 
        :office_id => @office.id,
        :username => username,
        :password => "",
        :name => "User 01"
      )
      
    user.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    username = "user01"
    user = User.create_object( 
        :office_id => @office.id,
        :username => username,
        :password => "user",
        :name => ""
      )
      
    user.should_not be_valid
  end
  
  it "should not allow object creation with duplicate username" do
    username = "user01"
    user =  User.create_object( 
        :office_id => @office.id,
        :username => username,
        :password => "user",
        :name => "User 01"
      )
      
    user.should be_valid
    
    user_2 = User.create_object( 
        :office_id => @office.id,
        :username => username,
        :password => "user",
        :name => "User 01"
      )
      
    user_2.should_not be_valid
  end
  
  context "has been created user" do
    before(:each) do
      @user_1_username = "user01"
      @user_1_password = "user"
      @user_1_name = "User 01"
      @user = User.create_object(
          :office_id => @office.id,
          :username => @user_1_username,
          :password => @user_1_password,
          :name => @user_1_name
        )
        
      @user_2_username = "user02"
      @user_2_password = "user"
      @user_2_name = "User 02"
      @user_2 = User.create_object(
          :office_id => @office.id,
          :username => @user_2_username,
          :password => @user_2_password,
          :name => @user_2_name
        )
    end
    
    it "should have 2 objects" do
      User.count.should == 2 
    end
    
    it "should create valid objects" do
      @user.should be_valid
      @user_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_username = "usr03"
      new_password = "user"
      new_name = "User 03"
      
      @user.update_object(
          :office_id => @office.id,
          :username => new_username,
          :password => new_password,
          :name => new_name
        )
        
      @user.should be_valid
      
      @user.reload 
      
      @user.name.should == new_name
      @user.username.should == new_username
      @user.password.should == new_password
    end
    
    it "should not allow duplicate username" do
      @user_2.update_object(
          :office_id => @office.id,
          :username => @user_1_username,
          :password => @user_2_password,
          :name => @user_2_name
        )
        
      @user_2.errors.size.should_not == 0 
      @user_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @user_2.delete_object
      
      @user_2.persisted?.should be_falsy  # be_truthy 
      
      User.count.should == 1 
    end
  end
end
