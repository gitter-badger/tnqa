require 'spec_helper'

describe Question do
	it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should ensure_length_of(:title).is_at_least(5) }
  it { should belong_to(:user) }
  it { should have_many(:answers)}
end
