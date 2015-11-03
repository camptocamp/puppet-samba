require 'spec_helper'

describe 'samba::server' do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir  => '/foo',
          :lsbdistcodename => 'jessie',
        })
      end

      it { should compile.with_all_deps }
    end
  end
end
