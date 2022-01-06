resource "yandex_storage_bucket" "netologybucket" {
  access_key    = var.bucket_access_key
  secret_key    = var.bucket_secret_key
  acl           = "public-read"
  bucket        = "netologybucket"
  force_destroy = "true"
  website {
    index_document = "index.html"
  }
}

resource "yandex_storage_object" "image-object" {
  access_key = var.bucket_access_key
  secret_key = var.bucket_secret_key
  acl        = "public-read"
  bucket     = "netologybucket"
  key        = "coffee.jpg"
  source     = "./files/coffee.jpg"
  depends_on = [
    yandex_storage_bucket.netologybucket,
  ]
}


