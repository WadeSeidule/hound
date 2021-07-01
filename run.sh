if [ -z $1 ]; then
	echo 'Enter the path to your ssh key. Ex: make run SSH_KEY_PATH=~/.ssh/key'
	exit
fi

SSH_KEY_PATH=$1
docker build --build-arg SSH_KEY="$(cat $SSH_KEY_PATH)" -t hound . &&
docker run -d -p 6080:6080 --name hound -v $(pwd):/data -t hound