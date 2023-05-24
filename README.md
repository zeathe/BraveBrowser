
Brave Browser in Docker
=======================

Overview
--------

Leveraging the great work by [jlesage](https://github.com/jlesage), the 
[baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) project
is used as a base to install the Brave browser within a container.

I personnally run this software in my own private K3S cluster where my
edge firewall only allows the worker nodes to route over my VPN solution. In
addition, the container itself has DNS hard-set to utilize the VPN provider's
protected DNS servers. This allows for running a TOR tab with some levels of
protection against script bypass identification which would then just reveal
my VPN provider.

Your setup may vary.


Running Locally in Docker Native
--------------------------------

I have not spent a whole lot of time attempting to do this.  Since I have
several kubernetes clusters available, this has been lower priority for me
to fix.

There are several mounts that are really only available on a Linux hosting
system for Docker that are required for the container/pod.  These are:

* configdir EmptyDir (could be a volume bind to any blank host dir)
* dshm Memory Map (/dev/shm)
* savedir PVC (could be a volume bind to any blank host dir)

The DSHM mapping, specifically, is not readily available on a Windows host
or clear as to what to bind on a MacOS host.  WSL also does not expose the
DSHM objects the same as a native linux host would when working with Docker
Desktop for Windows.  Natively installing Docker directly in a WSL VM would
probably solve this in part, but complicate the docker port exposure.

Your mileage may vary.

Some time, I might invest cycles in to solving this... but it is easy to
fire up a K3S cluster, the Docker Destop K8S cluster or other Kubernetes 
offerings to provide a sandbox.


Running In Kubernetes
---------------------

### Pre-setup

#### Create a Deployment Set for a K8s Cluster

In the `Kustomize/DeployTargets/Example` directory, you will find two patch
files and a kustomization file.  It is best to copy this structure to a
memorable name for your k8s deployment target.  In this example, let's just
say it is K8S-DOOKER-01 for a cluster name.

Copy the files:

```bash
$ cp -Rv ./Kustomize/DeployTargets/Example ./Kustomize/DeployTargets/K8S-DOOKER-01
```
#### Update the VNC Password

Edit the `brave-secrets.yml` kustomize patch file in the K8S-DOOKER-01 kustomize 
directory.

The value for the VNCPassword will need to be a base64-encoded clear text
string.  The default value set in both BASE and in the Example kustomize patch
file is simply `P@ssw0rd`.  It is highly encouraged to change this.

You can generate a new password string easily like the following:

```bash
$ echo MyNewPasswordString | base64
```

This would result in the value `TXlOZXdQYXNzd29yZFN0cmluZwo=`.  It is highly
suggested to use a much stronger password.  Be aware of special characters
being interpreted in the bash prompt prior to being piped to base64.

#### Update the pod DNS settings

Edit the `brave-deploy.yml` kustomize patch file in the K8S-DOOKER-01 kustomize
directory.  Set the DNS settings as would be approriate for your kubernetes
cluster and local network.  Again, a reminder that your security of using Brave
in this sandbox pod is only as secure as your kubernetes cluster worker nodes,
their networking configuration, and their inbound/outbound allowances on your
firewall edge.


#### Deploy

Once your patch files are updated, deploy the workload as you would normally
deploy a kustomize unit: 

`kubectl apply -k ./Kustomize/DeployTargets/K8S-DOOKER-01`


