require File.expand_path("../spec_helper", __FILE__)

describe Palmade::DbEssentials::Exts::MapPolymorphicType do
  class Person < ActiveRecord::Base
    include Palmade::DbEssentials::Exts::MapPolymorphicType

    has_many :comments, :as => :authorable
    map_polymorphic_type :comments, "Mark"
  end

  class Comments < ActiveRecord::Base
    include Palmade::DbEssentials::Exts::MapPolymorphicType

    belongs_to :authorable, :polymorphic => true
    map_polymorphic_type :authorable, "People" => "Person"
    map_polymorphic_type :authorable, "Mark" => "Person"
  end

  context "reflection" do
    it "should contain comments association" do
      Person.reflections.include?(:comments).should be_true
    end

    it "should contain authorable association" do
      Comments.reflections.include?(:authorable).should be_true
    end

    it "should have a mapping for comments association" do
      mtp = Person.read_inheritable_attribute(:polymorphic_type_map)

      mtp.should be_an_instance_of Hash
      mtp.should_not be_empty
      mtp[:comments].should_not == nil
      mtp[:comments].should_not be_empty
      mtp[:comments][0].should == "Person"
      mtp[:comments][1].should == "Mark"
    end

    it "should have a mapping for authorable association" do
      mtp = Comments.read_inheritable_attribute(:polymorphic_type_map)
      mtp.should be_an_instance_of Hash
      mtp.should_not be_empty
      mtp[:authorable].should_not == nil
      mtp[:authorable].should_not be_empty
      mtp[:authorable].include?("People").should be_true
      mtp[:authorable]["People"].should == "Person"
      mtp[:authorable].include?("Mark").should be_true
      mtp[:authorable]["Mark"].should == "Person"
    end
  end
end
