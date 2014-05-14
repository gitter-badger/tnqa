require 'spec_helper'

describe Answer do
  it { should validate_presence_of(:content) }
  it { should ensure_length_of(:content).is_at_least(5) }
  it { should belong_to(:question) }
end
