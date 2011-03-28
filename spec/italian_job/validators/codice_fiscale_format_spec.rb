require "spec_helper"

describe "codice_fiscale_validator" do

    before(:each) do
        @user = User.new
    end

    context "with no values" do

        it "should be invalid" do
            @user.should_not be_valid
        end

        it "should have an error" do
            @user.should have(1).errors_on(:codice_fiscale)
        end

        it "should return an empty error" do
            @user.errors[:codice_fiscale].should == [I18n.translate("activerecord.errors.codice_fiscale.empty")]
        end

    end


    VALID_CODES.each do |code|
        context "with the valid code #{code}" do
            it "should have no errors" do
                @user.codice_fiscale = code
                @user.should have(:no).errors_on(:codice_fiscale)
            end
        end
    end

    INVALID_CODES.each do |code|

        context "with the invalid code #{code}" do

            it "should have an error" do
                @user.codice_fiscale = code
                @user.should have(1).error_on(:codice_fiscale)
            end

            it "should return an invalid_format error" do
                @user.codice_fiscale = code
                @user.errors[:codice_fiscale].should == [I18n.translate("activerecord.errors.codice_fiscale.invalid_format")]
            end


        end
    end

end
