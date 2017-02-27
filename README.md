Getting Started
===============

To start quickly with a demo-quality single-node kubernetes cluster, try
[minikube](https://kubernetes.io/docs/getting-started-guides/minikube/).

Storage
-------

Create storage for pulp, qpidd, and mongodb. Before creating these resources,
adjust each `PersistentVolume` to match the storage you can provide. The
defaults only work on a single-node deployment (such as minikube).

    kubectl create -f resources/vlp.yaml
    kubectl create -f resources/vlq.yaml
    kubectl create -f resources/vlm.yaml


Secrets
-------

server.conf
^^^^^^^^^^^

Edit `secrets/full-server.conf` to your liking. Consider such settings as the
default admin password. For settings that are already populated with
non-default values, those values are likely important to integration with other
k8s resources. It's wise to understand the current value before changing it.

"minify" the config when you are done. You will see it create `server.conf`.

    make-server-conf.sh

Certificates
^^^^^^^^^^^^

This script creates a self-signed CA, and all of the certificates needed by the
various pulp services.

    make-certs.sh

If you prefer to provide your own certificates, pause here and replace what was
generated. Most of the output is in the `certs` directory, but `qpidd` requires
an NSS database found in the `qpidd` directory.

RSA Key Pair
^^^^^^^^^^^^

Just run the script to generate the pair.

    pulp-gen-key-pair

Commit
^^^^^^

Done! Now run the provided script to "commit" the secrets into k8s.

    commit.sh

At any time you can stop services, run `delete.sh` to remove the secrets from
k8s, modify values as you like, and then re-commit with `commit.sh`. Then start
everything back up.


Supporting Services
-------------------

MongoDB and Qpid are ready to be started. They must remain singletons, so do
not scale beyond 1 pod each.

    kubectl -f resources/mongo.yaml
    kubectl -f resources/qpid.yaml


Setup
-----

Almost done. We need two setup steps.

The first time you deploy, run the `setup` pod to establish the correct
filesystem layout on your shared storage.

    kubectl -f resources/setup.yaml

Watch for the `setup` pod to finish by running this command:

    kubectl get pods -a

Every time you deploy a new version of Pulp, including the first deployment,
run `pulp-manage-db`. Make sure that no Pulp services are running.

    kubectl -f resources/manage.yaml

As above, watch for completion with this command:

    kubectl get pods -a


Start Pulp
----------

This script is a shortcut for creating the Pulp resources. Before creating
them, feel free to adjust the number of replicas of each `Deployment` resource.

    up.sh


Access Pulp
-----------

This deployment uses the most recent Fedora release in the contain images. For
now, it is up to you to run your own machine with the same version of Fedora,
or otherwise install `pulp-admin` of the same version that matches the images.

Since I use Fedora on my laptop anyway, this document will proceed with that.

Start by [installing pulp-admin](http://docs.pulpproject.org/user-guide/installation/f24+.html#admin-client).

Create the file `~/.pulp/admin.conf` with these contents, adjusted for wherever
you have this git repository checked out.

    [server]
    host = pulpapi
    port = 30443
    ca_path = /home/mhrivnak/git/pulp-k8s/secrets/certs/ca.crt

Find the external IP address for one or more nodes in your cluster. If using
minikube:

    minikube ip

Edit your `/etc/hosts` file so the name `pulpapi` resolved to those addresses.

    sudo echo 192.168.42.149 pulpapi >> /etc/hosts 

Cross your fingers, and then clumsily type:

    pulp-admin status

You are now free to log in and use Pulp as normal.
