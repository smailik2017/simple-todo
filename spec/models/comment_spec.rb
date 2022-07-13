require 'rails_helper'

RSpec.describe Comment, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { is_expected.to belong_to(:parent) }
  it { is_expected.to have_many(:children) }
end
