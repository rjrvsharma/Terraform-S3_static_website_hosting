// Create an S3 bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketName
}

// Configure object ownership so the bucket owner owns uploaded objects
resource "aws_s3_bucket_ownership_controls" "ownership" {
    bucket = aws_s3_bucket.mybucket.id

    rule {
      object_ownership = "BucketOwnerPreferred"
    }
}

// Allow public access settings to be configured on the bucket
resource "aws_s3_bucket_public_access_block" "puclicaccess" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


// Apply a public-read ACL so website files can be accessed from the internet
resource "aws_s3_bucket_acl" "aclaccess" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership,
    aws_s3_bucket_public_access_block.puclicaccess,
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

// Upload the main website page to the S3 bucket
resource "aws_s3_object" "index" {
   bucket = aws_s3_bucket.mybucket.id  //bucket name
   key = "index.html"   //root file
   source = "index.html"   //destination-path of the file
   acl = "public-read"    
   content_type = "text/html"   
}

// Upload the custom error page to the S3 bucket
resource "aws_s3_object" "error" {
   bucket = aws_s3_bucket.mybucket.id 
   key = "error.html"   
   source = "error.html"   
   acl = "public-read"    
   content_type = "text/html"   
}

// Enable static website hosting on the S3 bucket
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  depends_on = [ aws_s3_bucket.mybucket ]
}