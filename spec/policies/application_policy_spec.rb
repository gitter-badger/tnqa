require "spec_helper"

describe ApplicationPolicy do
	let(:user) { create(:user) }
  let(:record) { create :question, user: user }

  subject { described_class.new(user, record) }

	context "#index?" do 
		it 'is false for current user nil' do 
			user = nil
			record = nil
			expect(subject.index?).to eq(false)
		end

		it 'is false for current user' do 
			expect(subject.index?).to eq(false)
    end
	end

	context "#update?" do 
		it 'is false for current user nil' do 
			user = nil
			record = nil
			expect(subject.update?).to eq(false)
		end

		it 'is false for current user' do 
			expect(subject.update?).to eq(false)
    end
	end

	context '#show?' do 
    it 'is true if object exists' do 
       expect(subject.show?).to eq(true)
    end
	end


end