Building a simple LAMP stack and deploying Application using Ansible Playbooks.
-------------------------------------------

These playbooks require Ansible 1.2.

These playbooks are meant to be a reference and starter's guide to building
Ansible Playbooks. These playbooks were tested on CentOS 6.x so we recommend
that you use CentOS or RHEL to test these modules.

This LAMP stack can be on a single node or multiple nodes. The inventory file
'hosts' defines the nodes in which the stacks should be configured.

        [master]
        kmaster

        [nodes]
        knode1
        knode2
        knode3

Here the webserver would be configured on the local host and the dbserver on a
server called "bensible". The stack can be deployed using the following
command:

        ansible-playbook -i hosts site.yml

Once done, you can check the results by browsing to http://localhost/index.php.
You should see a simple test page and a list of databases retrieved from the
database server.

### Steps

* share ssh public keys to the used hosts
* create an internal network
* setup hostnames for public network
* setup hostnames for internal network
* add kubernetes and docker repository
* install docker on all hosts
    * install kubelet kubeadm kubectl on master
    * install kubelet kubeadm kubectl on nodes
* kubeadm init --pod-network-cidr 10.244.0.0/16
* join each node to cluster: kubeadm join 0.0.0.0:6443 --token m0nndw.fi4anf5wnsu2fld5 --discovery-token-ca-cert-hash sha256:fed0786b8009xxxxxxxxxxxxxxxxxxxxxb7e908da43e799495e7251fee007709'
    * cp /etc/kubernetes/admin.conf .
    * export KUBECONFIG=$HOME/admin.conf
    * kubectl --kubeconfig /etc/kubernetes/admin.conf get nodes
* kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml