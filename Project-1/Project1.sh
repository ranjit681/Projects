Jenkins CI/CD Pipeline - SonarQube, Docker, Github Webhooks on AWS

https://www.youtube.com/watch?v=361bfIvXMBI&t=814s

1. Create a Rep0
2. Push the code from freecss 
3. Create a 3 EC2 Jenkins, Docker & SonarQube with T2 Medium
4. Enable port 8080, 9000, 8085

Jenkins

sudo hostnamectl set-hostname jenkins
/bin/bash
sudo apt update -y
sudo apt update
sudo apt install openjdk-11-jre
java -version

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

sudo apt-get install jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins


New Item--> Automated Project--> Free style {Prokect

Build Trigger --> Github Web hook
sources code management --> Copy the url and paste and chnage the branch name

Github --> Enable the github hook
Add web hook > Payload url Paste > Ip adreess:8080/github-webhook
all
Build now
Create new file on github to check everything is working


SonarQube
sudo hostnamectl set-hostname sonarqube
/bin/bash

sudo apt install openjdk-17-jre
java -version

sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.3.0.82913.zip

sudo apt install unzip
ls
unzip sonar zip
cd bin > cd linux > ./sonar.sh > ./sonar.sh console
Copy the url and paste:9000
admin>admin
New: admin123
Manual: Onix-website-scan Same name > set up
with jenkins > continue > Copy the prokect key 
my account > security > Sonarqube-token > Copy the Tocken

Go to Jenkins > Manage Jenkins > Available Plugins > Sonarqube-scanner & SSH2 easy

/Manage/configureTools/ > Add Sonar Scanner > SonarScanner
/Manage/configure/ > Sonar Qube Servers > Sonarqube Installation > Sonar-Server> Url: :9000
>Server authentication Token > Add > Jenkins> Kind> Secret Text> Paste> Sonar-Token
> Select the token

job/Automated-pipeline/configure 
> Build Steps > Execute SonarQube Scanner > Analysis Properties > paste key _Scan

Build Now: Refresh the page in Sonarqube

Docker:
sudo hostnamectl set-hostname docker
/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu


sudo su jenkins

Docker> sudo su > nano /etc/ssh/sshd_config
> Uncomment PubkeyAuthentication yes > PasswordAuthentication yes
> systemctl restart sshd_config
> passwd ubuntu



> Jenkins > ssh ubuntu@docker Ip
password:
Exit

Jenkins > ssh-keygen
ssh-copy-id ubuntu@docker ip


Jenkins > /manage/configure > server group center > Add Group List
>Docker-Servers > 22 > ubuntu > Docker passwd

Jenkins > /manage/configure > Server List > Server Group > Docker-Server > Server Name: Docker-1 > Sercer IP: IP of Docker 

/job/Automated-pipeline/configure
Post Build Actions: Add Build Step : Remote Shell > Target Server >
shell: touch test.txt

Build Now

Docker: ls
mkdir website

Githib: Create File > Dockerfile

FROM nginx
COPY ./usr/share/nginx/html/

/job/Automated-pipeline/configure
Remove the remote shell

Post build Actions: Execute Shell> scp -r ./* ubuntu@ip:~/website/
Docker: ls

/job/Automated-pipeline/configure
Add Remote Shell
Shell: cd /home/ubuntu/website
docker build -t mywebsite .
docker run -d -p 8085:80 --name=onix-website mywebsite
Save



Docker: docker ps
sudo usermod -aG docker ubuntu
Run












