require 'spec_helper'
describe 'monitor' do

  context 'with defaults for all parameters' do
    it { should contain_class('monitor') }
  end
end
