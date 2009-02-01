require File.join(File.dirname(__FILE__), 'spec_helper')

describe SimpleColumnSearch do
  before(:each) do
    Person.delete_all
    
    @jqr = Person.create(:first_name => 'Elijah', :last_name => 'Miller', :alias => 'jqr')
    @iggzero = Person.create(:first_name => 'Kristopher', :last_name => 'Chambers', :alias => 'iggzero')
    @mogis = Person.create(:first_name => 'Brent', :last_name => 'Wooden', :alias => 'mogis')
    @shakewell = Person.create(:first_name => 'Amanda', :last_name => 'Miller', :alias => 'shakewell')
    
    @users = [@jqr, @iggzero, @mogis, @shakewell]
  end
  describe "single column search" do
    it "should find someone by first name" do
      Person.search_first_name('Eli').should == [@jqr]
    end

    it "should not find someone by last name" do
      Person.search_first_name('Miller').should == []
    end
  end
  
  describe "multi column search" do
    it "should find someone by first name" do
      Person.search('Eli').should == [@jqr]
    end

    it "should find someone by last name" do
      Person.search('Chambers').should == [@iggzero]
    end

    it "should find someone by alias" do
      Person.search('mogis').should == [@mogis]
    end
    
    
    it "should not be case sensitive" do
      Person.search('amanda').should == [@shakewell]
    end
    
    
    it "should find multiple people by last name" do
      Person.search('Miller').should == [@jqr, @shakewell]
    end
    
    
    it "should limit results by all terms" do
      Person.search('E Miller').should == [@jqr]
      Person.search('K C').should == [@iggzero]
      Person.search('Br Wo mo').should == [@mogis]
      Person.search('shake Miller').should == [@shakewell]
    end
  end
  
end
