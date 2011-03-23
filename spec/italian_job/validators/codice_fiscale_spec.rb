require "spec_helper"

describe "codice_fiscale_validator" do
    before(:each) do
        @user = User.new
    end

    it "should be invalid if empty" do
        @user.should have(1).errors_on(:codice_fiscale)
    end
end
