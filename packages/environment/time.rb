package :time do

  apt 'ntp' do
    post :install, 'ntpdate -u ntp.ubuntu.com'
  end

end
