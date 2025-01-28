environments = ["dev", "beta"]
app = {
 name = "next-app"
 image = "nginx:alpine"
 replicas = 2
 port = 80
}