require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    describe 'user name' do
      describe 'presence' do
        before do
          user.username = nil
          user.valid?
        end
        it { expect(user.errors.messages[:username]).to include "can't be blank"}
      end

      describe 'length' do
        before do
          user.username = "a"
          user.valid?
        end
        it { expect(user.errors.messages[:username]).to include "is too short (minimum is 2 characters)"}
      end
    end
  end
end