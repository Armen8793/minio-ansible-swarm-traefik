# Here is a Minio with Traefik deployed by Ansible

## To make Minio work fine, on all nodes run
```
docker node update --label-add minio.replica=1 minio-01
docker node update --label-add minio.admin=true minio-02
docker node update --label-add minio.replica=3 minio-03
docker node update --label-add minio.replica=2 minio-02
```

## This project lets you automated make your servers a Swarm cluster (init and join nodes), install on its nodes traefik as a reverse-proxy and deploy Minio behind Traefik to the Swarm, do backups of minio 2 times a day saving only past two, just run
```
ansible-playbook -i hosts1 playbook.yaml
```
## There is a role to restore Minio backup if it is needed, it is false by default in playbook, but if you ever need to restore backup, just run the following command
```
ansible-playbook -i hosts playbook.yml -e "restore_backup=true"
```

## access_key and secret_key are as a login and password of minio, create them with the command below
```
echo "write-here-anything-you-want-to-create" | docker secret create access_key -
echo "write-here-anything-you-want-to-create" | docker secret create secret_key -
```

## All said here except for restoring will be automates by Gitlab Ci
