BREW_INSTALL_URL = "https://raw.githubusercontent.com/Homebrew/install/master/install"

execute "Install brew" do
  command "ruby -e \"$(curl -fsSL #{BREW_INSTALL_URL})\""
  not_if "test $(which brew)"
end

node["brew"]["install_packages"].each do |package|
  execute "Install bin packages" do
    command "brew install #{package}"
    not_if "brew list | grep -q #{package}"
  end
end

node["brew"]["install_apps"].each do |app|
  execute "Install apps" do
    command "brew cask install #{app} --appdir=\"/Applications\""
    not_if "brew cask list | grep -q #{app}"
  end
end

