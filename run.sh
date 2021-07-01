docker build --build-arg SSH_KEY="$(cat ~/.ssh/id_ed25519)" -t hound . &&
docker run -d -p 6080:6080 --name hound -v $(pwd):/data -t hound