output "alb_dns" {
  value = module.ecs.alb_endpoint
}

output "url" {
  value = module.ecs.url
}