#!/bin/sh

# `/home/usmqe` is directory where all scripts and repos from
# https://github.com/usmqe/ are

/home/usmqe/snapshotscriptgl.sh "snapshot-revert --snapshotname before-import"
/home/usmqe/snapshotscriptgl.sh "start"
sleep 5
ansible-playbook /home/usmqe/usmqe-setup/qe_evidence.tendrl.yml --extra-vars "evidence_target=/home/usmqe/target"
cd /home/usmqe/target
git init
git add *
git commit -m "initial commit"
cd /home/usmqe/usmqe-tests
sleep $(expr $1 / 5)
python3 -m pytest usmqe_tests/api/gluster/test_gluster_cluster.py -k test_cluster_import_valid
sleep 5
ansible-playbook /home/usmqe/usmqe-setup/qe_evidence.tendrl.yml --extra-vars "evidence_target=/home/usmqe/target"
cd /home/usmqe/target
git add *
git commit -m "post import"
cd /home/usmqe
tar -czf results$(echo $1).tar.gz /home/usmqe/target
rm -rf /home/usmqe/target
mkdir /home/usmqe/target
