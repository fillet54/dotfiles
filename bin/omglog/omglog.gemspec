--- !ruby/object:Gem::Specification
name: omglog
version: !ruby/object:Gem::Version
  version: 0.0.2.1
  prerelease: 
  segments:
  - 0
  - 0
  - 2
  - 1
platform: ruby
authors:
- Ben Hoskings
- Phil Gomez
autorequire: 
bindir: bin
cert_chain: []
date: 2012-01-20 00:00:00.000000000Z
dependencies:
- !ruby/object:Gem::Dependency
  name: rb-fsevent
  requirement: &70315749462200 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: 0.4.3
  type: :runtime
  prerelease: false
  version_requirements: *70315749462200
description: Realtime git logging using fseventsd. omg!
email: ben@hoskings.net
executables:
- omglog
extensions: []
extra_rdoc_files: []
files:
- bin/omglog
homepage: http://github.com/fillet54/dotfiles
licenses: []
post_install_message: 
rdoc_options: []
require_paths:
- lib
required_ruby_version: !ruby/object:Gem::Requirement
  none: false
  requirements:
  - - ! '>='
    - !ruby/object:Gem::Version
      version: '0'
required_rubygems_version: !ruby/object:Gem::Requirement
  none: false
  requirements:
  - - ! '>='
    - !ruby/object:Gem::Version
      version: '0'
requirements: []
rubyforge_project: 
rubygems_version: 1.8.15
signing_key: 
specification_version: 3
summary: Realtime git logging using fseventsd.
test_files: []

