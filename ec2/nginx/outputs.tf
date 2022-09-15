##-- EC2 NGINX Outputs --##

output "nginx_ip" {
    value = "aws_instance.ec2_nginx.private_ip"
}

