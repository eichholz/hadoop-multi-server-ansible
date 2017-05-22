# Hadoop multi-node cluster with Ansible
Multi-server deployment of Hadoop using Ansible

This repository contains a set of Vagrant and Ansible scripts that make it fast and easy to build a fully functional Hadoop cluster, including HDFS, on a single computer using VMware Fusion / VirtualBox.

## Setup

 - Clone this repository
 - (optional) Download a binary release of hadoop (e.g. http://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz) and saved it to `roles/common/templates/hadoop-2.7.1.tar.gz` then update `roles/common/tasks/main.yml` to use the alternative approach
 - Open a command prompt to the directory where you cloned the code
 - Run `vagrant up`
 - Run `vagrant ssh master`to SSH into the master node
   - Change directory to `/home/vagrant/src`
   - Run the ansible playbook: `ansible-playbook -i hosts-dev playbook.yml`
   - For all hadoop-related tasks change to user hadoop: `sudo su - hadoop`
   - Format the HDFS namenode: `hdfs namenode -format`
   - Start DFS and YARN:
     - `/usr/local/hadoop/sbin/start-dfs.sh`
     - `/usr/local/hadoop/sbin/start-yarn.sh`
   - `hdfs dfsadmin -report`
   - `$HADOOP_HOME/sbin/slaves.sh jps`
   - Run an example job: `hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar pi 10 30`
   - Stop DFS and YARN:
     - `/usr/local/hadoop/sbin/stop-dfs.sh`
     - `/usr/local/hadoop/sbin/stop-yarn.sh`

### Troubleshooting
- Make sure that no localhost-related entries are present in `/etc/hosts` (**TODO:** Check if this is already covered by Ansible script)

## Hadoop Tutorial
### Initial steps

Switch to user _hadoop_: `sudo su - hadoop`

Format NameNode: `hdfs namenode -format`

Start HDFS: `/usr/local/hadoop/sbin/start-dfs.sh`

Start YARN: `/usr/local/hadoop/sbin/start-yarn.`

_YARN is the overhauled version of MapReduce (MapReduce 2.0) in Hadoop. The fundamental idea is to split up the two major functionalities of the JobTracker, resource management and job scheduling / monitoring, into separate daemons._

### HDFS demo steps

Show JPS (Java Virtual Machine Process Status) tool: `$HADOOP_HOME/sbin/slaves.sh jps`

Show HDFS status on command line / Show disk usage of all nodes individually: `hdfs dfsadmin -report`

Show total disk space: `hdfs dfs -df -h` (same as command to show local disk space `df -h`)

Show Datanode web interface: `192.168.51.4:50070`

Show Hadoop cluster web interface: `192.168.51.4:8088`

#### Generate file with arbitrary content

Create file of size _count * bs_ bytes. bs = (1024 * 1024 bytes) = 1048576 bytes = 1 Mb

`dd if=/dev/zero of=output.txt count=1024 bs=1048576`

#### Load file into HDFS from local
Show Datanode information on web interface before and after operation

`hdfs dfs -copyFromLocal /home/vagrant/src/random_numbers.txt /random_numbers.txt`

1. List file system
2. Upload small file (size < BLOCK_SIZE)
3. Show block distribution in web interface
4. Delete file
5. List file system
6. Upload larger file (spanning multiple blocks)
7. Show block size on command line
8. Show block size in web interface

`hdf fsck -blocks -files -locations /random_numbers.txt`

### MapReduce demo steps

Run PI calculation example

`hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar pi 10 30`

Run custom MapReduce job locally

`java -cp hadoop-ctbd-jar-with-dependencies.jar de.tud.stg.WordCount ../input/wordcount ../output/wordcount`

Run custom MapReduce job on cluster

`hadoop -jar hadoop-ctbd-jar-with-dependencies.jar de.tud.stg.WordCount input output`

Retrieve result from HDFS: `hdfs dfs -get /hdfs/path /local/path`
