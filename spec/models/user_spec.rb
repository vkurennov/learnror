require 'spec_helper'

describe User do
  before do
    @user = User.new(first_name: 'John', last_name: 'Smith')
  end

  it 'should validates presence of first_name' do
    @user.first_name = nil
    @user.should_not be_valid
  end

  it 'should validates presence of last_name' do
    @user.last_name = nil
    @user.should_not be_valid
    expect(@user).to_not be_valid
  end

  #it { should have_many :projects }
  #it { should belong_to :role }
  #
  #it { should validate_presence_of :first_name }
  #it { should validate_presence_of :last_name }
  #it { should validate_presence_of :name }

end
