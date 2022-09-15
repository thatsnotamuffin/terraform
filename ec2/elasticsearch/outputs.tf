##-- EC2 Elasticsearch Outputs --##

output "elastic_ip" {
    value = "aws_instance.elasticsearch_instances.private_ip"
}

