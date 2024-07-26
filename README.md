## Infrastructure assignment 🌎

As we prepare to expand globally in the coming months, our goal is to simplify the creation of environments in various regions worldwide. To keep the process straightforward, we will focus on a smaller subset of our current infrastructure. The objective of this exercise is to evaluate your ability to maintain your IaC DRY, scalable, and clear.

Using Terraform, or preferably Terragrunt, please create the necessary files to deploy a new environment based on the following setup:

1. **VPC**:
   - This VPC should encompass all resources created within the environment.
   - It should span multiple zones with both public and private subnets.

2. **Kubernetes Cluster**:
   - Preferably running the latest version.
   - Must include these essential components: a CNI, Kube-proxy, CoreDNS, and either Cluster Autoscaler or Karpenter.

3. **Database**:
   - Single instance per region, without multi-zone availability.
   - Any database flavor is acceptable.
   - Should span across different environments.

You should configure 2 regions, with the first serving as the main region. Each region should have its own dedicated Kubernetes cluster. The database should span both regions, with the master instance in the main region and a read replica in the second region. You may choose any cloud provider. While we use AWS at Omi and will provide AWS credentials, you're welcome to use any provider you are more comfortable with, but you will need to manage the credentials yourself if you opt for another provider.

We do not expect you to create the environments. Successfully executing a `terragrunt --terragrunt-working-dir environments/production run-all plan` command will suffice.

An example directory structure is provided in the repository. You are free to use it or create your own.

### Objectives of the Test:
- Assess your ability to maintain DRY IaC.
- Evaluate your Terraform/Terragrunt proficiency.
- Measure your competence in designing multi-region deployments.
- Gauge your understanding of cloud provider and Kubernetes resources.

### What the Test is Not About:
- Writing an entire module from scratch to deploy a self-managed Kubernetes cluster. You are encouraged to use pre-existing open-source modules.
- Creating your own Helm charts. Utilizing pre-existing open-source charts is recommended.

### Optional Steps:
If you find the test too time-consuming, you may:
- Skip spanning the database across different environments.
- Add only one essential component to the Kubernetes cluster instead of all of them.

Good luck!