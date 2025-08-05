# Kyverno
## why
- Ensures best practices, compliance, and security standards for K8S resources
- Kubernetes Native, No need to learn a new language: Policies are written in YAML.
- Muttation (Automatically modifies resources to conform to policy.)
- Generate Resources (Can automatically create/configure resources when others are created)
- No native OCI solution for these
## what
- Kyverno is a Kubernetes-native policy engine that helps manage, validate, mutate, and generate Kubernetes resources. 
## how
- Automate OKE deploy with TF
- use helm chart to install Kyverno
- Write policy in YAML → store in Git.
- Validate policy locally using kyverno apply.
- Push to Git → triggers GitOps sync (ArgoCD/FluxCD).
- Policy gets deployed automatically to the cluster.



bosule am nevoie pentru kyverno si solutiile tale cu token si github, am facut un template ca sa fie mai usor. Cel mai important e beneficiul/impactul pe care il are daca putem rula acea solutie in OCI:

#Project: Kyverno
#Started or not: Yes
#Estimated timeline: 11-Aug
#Impact(Why?):
- Ensures best practices, compliance, and security standards for K8S resources
- Kubernetes Native, No need to learn a new language: Policies are written in YAML.
- Muttation (Automatically modifies resources to conform to policy.)
- Generate Resources (Can automatically create/configure resources when others are created)
- No native OCI solution for these
#use case(what):
- Kyverno is a Kubernetes-native policy engine that helps manage, validate, mutate, and generate Kubernetes resources. 
#Name of Customer: No customer
#Delivarables/reusable assets:
- Automate OKE deploy with TF
- use helm chart to install Kyverno
- Write policy in YAML → store in Git.
- Validate policy locally using kyverno apply.
- Push to Git → triggers GitOps sync (ArgoCD/FluxCD).
- Policy gets deployed automatically to the cluster.



#Project: Token Exchange Grant Type: Exchanging a JSON Web Token for a UPST
#Started or not: Yes
#Estimated timeline: 18-Aug
#Impact(Why?):
- Customers don't want to store long lived token/Api keys in Github
- Enhance security as token expires and cannot be used.
#use case(what):
- A Github Action workflow that uses a short lived JWT token to exchange an UPST token to authenticate to OCI. 
#Name of Customer: Wesco
#Delivarables/reusable assets:
- The github action workflow can be reused with minimal updates
