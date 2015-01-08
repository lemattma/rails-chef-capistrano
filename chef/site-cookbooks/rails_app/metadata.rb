name             'rails_app'
maintainer       'Martin Miranda'
maintainer_email 'martinmirandac@gmail.com'
description      'Installs/Configures Rails Server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apt"
depends "nginx"
depends "git"
depends "postgresql"
depends "build-essential"
depends "rvm"
depends "database"
