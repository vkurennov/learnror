require 'spec_helper'

describe User do
  let!(:user) { User.create!(email: 'test@user.com', password: '12345678', password_confirmation: '12345678') }
  let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

  describe ".find_for_oauth" do
    context 'user already has authorization' do
      it 'returns user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'user already registered' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'test@user.com' }) }

        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          user = User.find_for_oauth(auth)
          authorization = user.authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'user not registered' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new@user.com' }) }

        it 'creates new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end

        it 'fills user email' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq 'new@user.com'
        end

        it 'creates authorization for user' do
          user = User.find_for_oauth(auth)

          expect(user.authorizations).to_not be_empty
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end

      context 'without email' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { }) }

        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'returns nil' do
          expect(User.find_for_oauth(auth)).to be_nil
        end
      end
    end
  end

  describe '#add_authorization' do
    context 'authorization does not exist' do
      it 'adds authorization to user' do
        expect { user.add_authorization(auth) }.to change(user.authorizations, :count).by(1)
      end

      it 'returns true' do
        expect(user.add_authorization(auth)).to be_true
      end
    end

    context 'authorization already exists' do
      context 'authorization associated with current user' do
        before { user.create_authorization(auth) }

        it 'does not add authorization' do
          expect { user.add_authorization(auth) }.to_not change(user.authorizations, :count)
        end

        it 'returns true' do
          expect(user.add_authorization(auth)).to be_true
        end
      end

      context 'autorization associated with other user' do
        let(:other) { User.create!(email: 'other@user.com', password: '12345678', password_confirmation: '12345678') }
        before { other.create_authorization(auth) }

        it 'does not add authorization' do
          expect { user.add_authorization(auth) }.to_not change(user.authorizations, :count)
        end

        it 'returns false' do
          expect(user.add_authorization(auth)).to be_false
        end
      end
    end
  end
end
