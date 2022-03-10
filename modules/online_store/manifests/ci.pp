class online_store::ci {
  include online_store


  package{ ['git', 'maven', 'openjdk-8-jdk']:
    ensure => installed,
  }

  class { 'jenkins': 
    config_hash => {
      'JAVA_ARGS' => { 'value' => '-Xmx256m'}
    }
  }

  $plugins = [
    'ssh-credentials',
    'credentials',
    'scm-api',
    'git-client',
    'git',
    'javadoc',
    'mailer',
    'maven-plugin',
    'greenballs',
    'ws-cleanup'
  ]

  jenkins::plugin { $plugins: }
}
