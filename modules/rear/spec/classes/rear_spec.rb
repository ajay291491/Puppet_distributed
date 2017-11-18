require 'spec_helper'

describe 'rear', :type => :class do

  context 'with defaults for all parameters' do
    it { should contain_class('rear') }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) {
        {
          :output_url => 'nfs://192.168.1.20/srv/rear/domain',
          :backup_url => 'nfs://192.168.1.20/srv/rear/domain',
          :backup_schedule => 'weekly',
          :ssh_root_password => 'Recover!1234'
        }
      }

      it { is_expected.to compile.with_all_deps }

      case facts[:osfamily]
      when 'RedHat'
        it { is_expected.to contain_class('rear::params') }
        it { is_expected.to contain_class('rear::install') }
        it { is_expected.to contain_class('rear::config') }
        it { is_expected.to contain_class('rear::service') }

        it { is_expected.to contain_package('rear').with_ensure('installed') }

        it { is_expected.to contain_file('/etc/rear/local.conf').with_ensure('file') }

        it { is_expected.to contain_file('/etc/cron.d/rear').with_ensure('file') }

        it 'should generate valid content for configuration file local.config' do
          content = catalogue.resource('file', '/etc/rear/local.conf').send(:parameters)[:content]
          expect(content).to match('OUTPUT=ISO')
          expect(content).to match('OUTPUT_URL=nfs://192.168.1.20/srv/rear/domain')
          expect(content).to match('BACKUP=NETFS')
          expect(content).to match('BACKUP_URL=nfs://192.168.1.20/srv/rear/domain')
          expect(content).to match('SSH_ROOT_PASSWORD=Recover!1234')
        end

        it 'should generate valid content for cron file rear' do
          content = catalogue.resource('file', '/etc/cron.d/rear').send(:parameters)[:content]
          expect(content).to match('0 2 \* \* 0 root /usr/sbin/rear mkbackup')
        end
      else
        it { is_expected.to contain_warning('The current operating system is not supported!') }
      end
    end
  end
end
