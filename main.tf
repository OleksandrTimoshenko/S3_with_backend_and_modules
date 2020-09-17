provider "aws" {
  region = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

#resource "null_resource" "yarn_build" {
#  provisioner "local-exec" {
#    command = "npm build"
#  }
#}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.flood_bucket.id

  policy = <<POLICY
{
   "Version":"2012-10-17",
   "Statement":[{
     "Sid":"PublicReadForGetBucketObjects",
       "Effect":"Allow",
       "Principal": "*",
       "Action":["s3:GetObject"],
       "Resource":["arn:aws:s3:::${aws_s3_bucket.flood_bucket.id}/*"
       ]
     }
   ]
 }
POLICY
}

resource "aws_s3_bucket_object" "game_static" {
  for_each = fileset("${path.module}/build", "**/*.*")

  bucket = aws_s3_bucket.flood_bucket.id
  key    = each.value
  source = "${path.module}/build/${each.value}"
  content_type = lookup(
    var.mime_types,
    reverse(split(".", each.value))[0],
    "application/octet-stream"
  )
 # depends_on = [
 #   null_resource.yarn_build
 # ]
}

resource "aws_s3_bucket" "flood_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"

  tags = {
    Name        = "Flood bucket"
    Environment = "Dev"
  }

  website {
    index_document = "index.html"
  }
}


output "flood-url" {
  value = aws_s3_bucket.flood_bucket.website_endpoint
}
