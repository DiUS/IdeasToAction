require 'aws-sdk'
require 'aws/s3'

namespace :actionman do
  desc 'Upload CloudFormation templates to s3'
  task :upload_templates => :environment do
    s3 = AWS::S3.new(
      :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    )
    template_bucket = s3.buckets['actionman-cfn-templates']

    Dir[File.join(File.dirname(__FILE__), '..', 'templates', '*')].each do |template|
      puts "Uploading template: #{File.basename(template)}"
      obj = template_bucket.objects[File.basename(template)]
      obj.write(File.open(template).read)
    end
  end
end