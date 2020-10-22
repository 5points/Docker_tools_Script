# if you prefer docker can run this command to generate a secret
#docker run --rm nineseconds/mtg generate-secret tls -c bing.com
docker run -d --restart always --name mtg --ulimit nofile=51200:51200 -p <your port>:3128  nineseconds/mtg:latest run <secret>
