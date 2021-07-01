SSH_KEY_PATH=~/.ssh/id_ed25519
docker build --build-arg SSH_KEY="$(cat $SSH_KEY_PATH)" -t hound . &&
docker run -d -p 6080:6080 --name hound -v $(pwd):/data -t hound