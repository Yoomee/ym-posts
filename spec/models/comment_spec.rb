require 'spec_helper'

describe Comment do
  
  it {should belong_to(:user)}
  it {should belong_to(:post)}
  
  describe do
    
    let(:comment) {FactoryGirl.create(:comment)}
    
    it "should be valid" do
      comment.should be_valid
    end
    
  end
  
end