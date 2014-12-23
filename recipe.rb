class Fail2ban < FPM::Cookery::Recipe
  description 'Daemon to ban hosts that cause multiple authentication errors'

  name     'fail2ban'
  version  '0.9.0'
  revision '3'

  homepage 'https://github.com/fail2ban/fail2ban'
  license  'GNU General Public License'

  depends 'python', 'python-inotify','systemd-python' 
  build_depends 'git', 'rpm-build', 'python-setuptools'
  
  source 'http://github.com/fail2ban/fail2ban', 
    :with => 'git',
    :tag => "#{version}" 


  def build
    safesystem 'python setup.py build'
  end

  def install
    etc('init.d').install 'files/redhat-initd'
    lib('systemd/system').install 'files/fail2ban.service'
    safesystem 'python setup.py install --root=../../tmp-dest --no-compile'
  end
  
end
