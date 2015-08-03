require 'rails_helper'

RSpec.describe Device, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    ip_address = "10.18.9.205"
    port = 4370
    name = "SSD"
    device = Device.create_object(
        :office_id => @office.id,
        :ip_address => ip_address,
        :port => port,
        :name => name
      )
      
    device.should be_valid
    
    device.ip_address.should == ip_address
    device.port.should == port
    device.port.should == port
  end
  
  it "should not allow object creation without office id" do
    ip_address = "10.18.9.205"
    port = 4370
    name = "SSD"
    device = Device.create_object(
        :office_id => "",
        :ip_address => ip_address,
        :port => port,
        :name => name
      )
      
    device.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    ip_address = "10.18.9.205"
    port = 4370
    name = "SSD"
    device = Device.create_object(
        :office_id => 0,
        :ip_address => ip_address,
        :port => port,
        :name => name
      )
      
    device.should_not be_valid
  end
  
  it "should not allow object creation without ip_address" do
    ip_address = "10.18.9.205"
    port = 4370
    name = "SSD"
    device = Device.create_object(
        :office_id => @office.id,
        :ip_address => "",
        :port => port,
        :name => name
      )
      
    device.should_not be_valid
  end
  
  it "should not allow object creation without port" do
    ip_address = "10.18.9.205"
    port = 4370
    name = "SSD"
    device = Device.create_object(
        :office_id => @office.id,
        :ip_address => ip_address,
        :port => "",
        :name => name
      )
      
    device.should_not be_valid
  end
  
  it "should not allow object creation without port" do
    ip_address = "10.18.9.205"
    port = 4370
    name = "SSD"
    device = Device.create_object(
        :office_id => @office.id,
        :ip_address => ip_address,
        :port => port,
        :name => ""
      )
      
    device.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    ip_address = "10.18.9.205"
    port = 4370
    name = "SSD"
    device = Device.create_object(
        :office_id => @office.id,
        :ip_address => ip_address,
        :port => port,
        :name => name
      )
      
    device.should be_valid

    device_2 = Device.create_object(
        :office_id => @office.id,
        :ip_address => ip_address,
        :port => port,
        :name => name
      )
      
    device_2.should_not be_valid
  end
  
  context "has been created device" do
    before(:each) do
      @device_1_ip_address = "10.18.9.205"
      @device_1_port = 4370
      @device_1_name = "SSD"
      @device = Device.create_object(
          :office_id => @office.id,
          :ip_address => @device_1_ip_address,
          :port => @device_1_port,
          :name => @device_1_name
        )
        
      @device_2_ip_address = "10.18.9.208"
      @device_2_port = 4370
      @device_2_name = "SSD 2"
      @device_2 = Device.create_object(
          :office_id => @office.id,
          :ip_address => @device_2_ip_address,
          :port => @device_2_port,
          :name => @device_2_name
        )
    end
    
    it "should have 2 objects" do
      Device.count.should == 2 
    end
    
    it "should create valid objects" do
      @device.should be_valid
      @device_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_ip_address = "192.168.1.1"
      new_port = 4370
      new_name = "SSD 3"
      
      @device.update_object(
          :office_id => @office.id,
          :ip_address => new_ip_address,
          :port => new_port,
          :name => new_name
        )
        
      @device.should be_valid
      
      @device.reload 
      
      @device.ip_address.should == new_ip_address
      @device.port.should == new_port
      @device.name.should == new_name
    end
    
    it "should not allow duplicate code" do
      @device_2.update_object(
          :office_id => @office.id,
          :code => @device_1_code,
          :name => @device_2_name
        )
        
      @device_2.errors.size.should_not == 0 
      @device_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @device_2.delete_object
      
      @device_2.persisted?.should be_falsy  # be_truthy 
      
      Device.count.should == 1 
    end
  end
end
