require "spec_helper"

describe "codice_fiscale_validator" do

    before(:each) do
        @user = User.new
    end

    it "should be invalid if empty" do
        @user.should_not be_valid
    end

    it "should have an error on the field if empty" do
        @user.should have(1).errors_on(:codice_fiscale)
        @user.errors[:codice_fiscale].should == [I18n.translate("activerecord.errors.codice_fiscale.empty")]
    end

    VALID_CODES.each { |code|
        it "should have no errors for #{code}" do
            @user.codice_fiscale = code
            @user.should have(:no).errors_on(:codice_fiscale)
        end
    }

    INVALID_CODES.each { |code|
        it "should have one error for #{code}" do
            @user.codice_fiscale = code
            @user.should have(1).error_on(:codice_fiscale)
        end

        it "should have an error on #{code}" do
            @user.should have(1).errors_on(:codice_fiscale)
            @user.errors[:codice_fiscale].should == [I18n.translate("activerecord.errors.codice_fiscale.invalid_format")]
        end
    }

end
