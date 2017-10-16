name             'sshusers'
maintainer       'KURT_GEIGER'
maintainer_email 'ecommerce.systems@kurtgeiger.com'
license          'All rights reserved'
description      'Creates users with ssh and sudo access'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'aws'
depends 'user'
