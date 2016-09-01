require 'elasticsearch/extensions/backup'

Model.new(:elasticsearch, 'Elasticsearch Backup') do
  database Elasticsearch do |db|
    db.url     = ENV['ELASTIC_URL']
    db.indices = ENV['BACKUP_INDICES']
    db.size    = ENV['BACKUP_SIZE'] || 500
    db.scroll  = ENV['BACKUP_SCROLL'] || '10m'
  end

  store_with S3 do |s3|
    s3.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    s3.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    s3.region = ENV['AWS_REGION']
    s3.bucket = ENV['AWS_BUCKET']
    s3.path = ENV['AWS_ELASTIC_PATH']
  end

  compress_with Gzip
end
