require 'rails_helper'

RSpec.describe ShiftDetail, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
          
      @shift = Shift.create_object(
            :office_id => @office.id,
            :code => "SFT",
            :name => "Shift",
            :start_time => 480,
            :duration => 8
          )
  end
  
  it "should create shift_detail with all field required" do
    shift_detail = ShiftDetail.create_object(
        :shift_id => @shift.id,
        :day_code => DAY_CODE[:monday],
        :start_time => 480,
        :duration => 8
        )
    
    shift_detail.should be_valid
    
    shift_detail.day_code.should == DAY_CODE[:monday]
  end
  
  it "should not create shift_detail without shift id" do
    shift_detail = ShiftDetail.create_object(
        :shift_id => "",
        :day_code => DAY_CODE[:monday],
        :start_time => 480,
        :duration => 8
        )
    
    shift_detail.should_not be_valid
  end
  
  it "should not create shift_detail with invalid shift id" do
    shift_detail = ShiftDetail.create_object(
        :shift_id => 0,
        :day_code => DAY_CODE[:monday],
        :start_time => 480,
        :duration => 8
        )
    
    shift_detail.should_not be_valid
  end
  
  it "should create shift_detail without day code" do
    shift_detail = ShiftDetail.create_object(
        :shift_id => @shift.id,
        :day_code => "",
        :start_time => 480,
        :duration => 8
        )
    
    shift_detail.should_not be_valid
  end
  
  it "should not create shift_detail without start time" do
      shift_detail = ShiftDetail.create_object(
          :shift_id => @shift.id,
          :day_code => DAY_CODE[:monday],
          :start_time => "",
          :duration => 8
          )
    
    shift_detail.should_not be_valid
  end
  
  it "should not create shift_detail with invalid start time" do
      shift_detail = ShiftDetail.create_object(
          :shift_id => @shift.id,
          :day_code => DAY_CODE[:monday],
          :start_time => -2,
          :duration => 8
          )
    
    shift_detail.should_not be_valid
  end
  
  it "should not create shift_detail without duration" do
      shift_detail = ShiftDetail.create_object(
          :shift_id => @shift.id,
          :day_code => DAY_CODE[:monday],
          :start_time => 480,
          :duration => ""
          )
    
    shift_detail.should_not be_valid
  end
  
  it "should not create shift_detail with invalid duration" do
      shift_detail = ShiftDetail.create_object(
          :shift_id => @shift.id,
          :day_code => DAY_CODE[:monday],
          :start_time => 480,
          :duration => 0
          )
    
    shift_detail.should_not be_valid
  end
  
  it "should not create shift_detail with duplicate code" do
      shift_detail = ShiftDetail.create_object(
          :shift_id => @shift.id,
          :day_code => DAY_CODE[:monday],
          :start_time => 480,
          :duration => 8
          )
      
      shift_detail.should be_valid
      
      shift_detail_2 = ShiftDetail.create_object(
          :shift_id => @shift.id,
          :day_code => DAY_CODE[:monday],
          :start_time => 480,
          :duration => 8
          )
      
      shift_detail_2.should_not be_valid
  end
  
  context "jika shift_detail sudah ada" do
      before (:each) do
          @shift_detail_1_day_code = DAY_CODE[:monday]
          @shift_detail_1_start_time = 480
          @shift_detail_1_duration = 8
          @shift_detail = ShiftDetail.create_object(
              :shift_id => @shift.id,
              :day_code => @shift_detail_1_day_code,
              :start_time => @shift_detail_1_start_time,
              :duration => @shift_detail_1_duration
              )
          
          @shift_detail_2_day_code = DAY_CODE[:tuesday]
          @shift_detail_2_start_time = 510
          @shift_detail_2_duration = 8 
          @shift_detail_2 = ShiftDetail.create_object(
              :shift_id => @shift.id,
              :day_code => @shift_detail_2_day_code,
              :start_time => @shift_detail_2_start_time,
              :duration => @shift_detail_2_duration
              )
      end
      
      it "should have 2 shift_detail" do
          ShiftDetail.count.should == 2
      end
      
      it "should create valid shift_detail" do
          @shift_detail.should be_valid
          @shift_detail_2.should be_valid
      end
      
      it "should be to update" do
          new_start_time = 500
          new_duration = 10
          
          @shift_detail.update_object(
              :shift_id => @shift.id,
              :day_code => DAY_CODE[:wednesday],
              :start_time => new_start_time,
              :duration => new_duration
              )
          
          @shift_detail.should be_valid
          
          @shift_detail.reload
          
          @shift_detail.start_time.should == new_start_time
          @shift_detail.duration.should == new_duration
      end
      
      it "should not allow duplicate code" do
          @shift_detail_2.update_object(
              :shift_id => @shift.id,
              :day_code => @shift_detail_1_day_code,
              :start_time => @shift_detail_2_start_time,
              :duration => @shift_detail_2_duration
              )
              
          @shift_detail_2.errors.size.should_not == 0
          @shift_detail_2.should_not be_valid
      end
      
      it "should be allow to delete shift_detail_2" do
          @shift_detail_2.delete_object
          
          @shift_detail_2.persisted?.should be_falsy
          
          ShiftDetail.count.should == 1
      end
  end
end
