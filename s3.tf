resource "aws_s3_bucket" "bucket1" {
 		 bucket = "ritbucket123"
		  acl    = "public-read"

		  tags = {
			  Name = "my bucket"
		  }
	}

resource "aws_s3_bucket_object"  "first_one" {
		key                    = "image"
  		bucket                 = aws_s3_bucket.bucket1.id
  		source                 = "https://github.com/ritwik-jha/instance_automation.git/Screenshot.png"
}