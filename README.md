# gke-autopilot

This repository is an example how to use autopilot in GKE. If you want yo read more about it:

- [Autopilot](https://cloud.google.com/kubernetes-engine/docs/concepts/autopilot-overview)

GKE Autopilot is a mode of operation in GKE in which Google manages your cluster configuration, including your nodes, scaling, security, and other preconfigured settings. Autopilot clusters are optimized to run most production workloads, and provision compute resources based on your Kubernetes manifests. The streamlined configuration follows GKE best practices and recommendations for cluster and workload setup, scalability, and security. For a list of built-in settings, refer to the [Autopilot and Standard comparison table](https://cloud.google.com/kubernetes-engine/docs/resources/autopilot-standard-feature-compariso).

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project.

### Prerequisites

- git
- terraform
- kubectl
- kubectx
- gcloud

To deloy this project you will need a Google Cloud account, [create here](https://cloud.google.com/).

#### Costs

This tutorial uses the following billable components of Google Cloud:

- [GKE](https://cloud.google.com/kubernetes-engine/pricing)

To generate a cost estimate based on your projected usage, use the [pricing calculator](https://cloud.google.com/products/calculator).

When you finish this tutorial, you can avoid continued billing by deleting the resources you created. For more information, see [Clean up](https://github.com/claick-oliveira/gke-autopilot#clean).

### Deploying

First of all you need to clone this repository:

```bash
git clone https://github.com/claick-oliveira/gke-autopilot
```

#### Infrastructure

First let's check the architecture that we will create.

#TODO: ## Add the architecture diagram

#### Terraform

Now that we know about the architecture and resources, let's create. First we need to connect our shell to the `gcloud`:

```bash
gcloud auth login
```

Now that we connected:

```bash
cd terraform
terraform apply
```

This project you need to fill some variables:

- **gcp_project_name**: The GCP project ID
- **gcp_region**: The GCP region
- **gcp_zone**: The GCP availability zone

### Connecting in the Cluster

First we need to connect in our GKE:

```bash
gcloud container clusters get-credentials <CLUSTER_NAME> --region <REGION> --project <PROJECT_ID>
```

To be easy and skaffold use the correct environment, let's configure `kubectx`:

Get the name of the environment:

```bash
kubectx
```

Now change the name for staging:

```bash
kubectx staging=<YOUR ENVIRONMENT>
```

#TODO: ## Add an examplekubernetes deployment

## Clean

To clean the files generated as coverage, builds, env you can use:

```bash
cd terraform
terraform destroy
```

## Contributing

Please read [CONTRIBUTING.md](https://github.com/claick-oliveira/gke-autopilot/blob/main/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

- **Claick Oliveira** - *Initial work* - [claick-oliveira](https://github.com/claick-oliveira)

See also the list of [contributors](https://github.com/claick-oliveira/gke-autopilot/contributors) who participated in this project.

## License

This project is licensed under the GNU General Public License - see the [LICENSE](LICENSE) file for details
