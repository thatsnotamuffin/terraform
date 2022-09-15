##-- EC2 MongoDB Outputs --##

output "mongo_ip" {
    value = "aws_instance.mongo_instances.private_ip"
}

