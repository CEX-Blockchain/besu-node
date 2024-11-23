module.exports = {
    apps: [{
      name: 'besu-node',
      script: '/usr/local/bin/besu/bin/besu --config-file="config.toml"',
      max_memory_restart: '10G',
      log_date_format: 'YYYY-MM-DD HH:mm:ss',
    }]
  }