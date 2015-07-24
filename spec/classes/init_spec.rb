require 'spec_helper'
describe 'tor' do

  context 'with defaults for all parameters' do
    it { should contain_class('tor') }
  end
end
