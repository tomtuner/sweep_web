module ApplicationHelper
  
  def s3_url
    if ENV['RAILS_ENV'] == "development" then
      "https://s3.amazonaws.com/qr-dev.sweep.kanzu/codes"
    else
      "https://s3.amazonaws.com/qr.sweep.kanzu/codes"
    end
  end
  
  def s3_bucket_name
    if ENV['RAILS_ENV'] == "development" then
      'qr-dev.sweep.kanzu/codes'
    else
      'qr.sweep.kanzu/codes'
    end
  end
  
  def upload_to_s3(fname, bucket)
    s3 = AWS::S3.new
    obj = s3.buckets[bucket].objects[fname]
    obj.write(Pathname.new(fname))
  end
  
end
