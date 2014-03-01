require 'spec_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }
  let(:user) { nil }

  describe 'admin' do
    let(:user) { User.create!(email: 'test@user.com', password: '12345678', password_confirmation: '12345678', admin: true) }

    it { should be_able_to :manage, :all }
  end

  describe 'user' do
    let(:user) { User.create!(email: 'test@user.com', password: '12345678', password_confirmation: '12345678') }

    it_behaves_like 'guest'
    it { should be_able_to :create, Bet }
    it { should be_able_to :manage, :profile }
  end

  describe 'guest' do
    it_behaves_like 'guest'
    it { should_not be_able_to :create, Bet }
  end
end