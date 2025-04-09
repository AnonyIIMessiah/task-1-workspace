## To run dockerfile withour docker-compose

` docker build -t jenkins ./jenkins `
` docker run -d -rm --name jenkins -p 8080:8080 -v ./jenkins/data:/var/jenkins_home -v ~/.aws:/root/.aws jenkins `