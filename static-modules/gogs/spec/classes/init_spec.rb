require 'spec_helper'
describe 'gogs' do

  context 'with defaults for all parameters' do
    it { should contain_class('gogs') }
  end
end
