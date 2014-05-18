require 'spec_helper'

describe Answer do
  it { should validate_presence_of(:content) }
  it { should belong_to(:question) }
  it { should have_many :attachments }

  it { should accept_nested_attributes_for :attachments }
end
