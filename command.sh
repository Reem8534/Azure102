git clone git@github.com:czofficial/Building-a-CICD-Pipeline-in-Azure.git

python -m venv ~/.udacity-devops
source ~/.udacity-devops/bin/activate

az webapp up -n udacity-flask-web-app -g udacity-rg

az webapp log tail -n udacity-flask-web-app -g udacity-rg