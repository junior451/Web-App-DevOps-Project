# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Contributors](#contributors)
- [License](#license)

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)

### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

- **Docker:** The application uses docker to containerise the app and host the image on docker hub

## Provisioning an AKS cluster with Terraform
Prerequisites
----
You should have Terraform installed
- Click on this [link](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) to install terraform on your operating system

- Check that the correct version was installed
```
terraform -v
```

steps to provisioning the networking component of the aks-cluster
1. create the directory and terraform files
```
  mkdir aks-terraform

  cd aks-terraform

  mkdir networking-module

  cd networking-module

  touch main.tf outputs.tf variables.tf
```

2. Define the variables to be used to provision the resources in variales.tf
- **resource_group_name**: this will have the default name  for the network resource group which will be used in the resource group
- **location**: this will specify the name of the location where the resources will be provisioned
- **vnet_address_space**: this will soecify the address space for the virtual network where the network resources will be placed

3. Define the following resources to be provisioned on azure in main.tf
- **Azure Resource Group**: This will contain the networking resources
- **Virtual Network(VNET)**: This is the vnet for the aks cluster
- **Control Plane Subnet**: This subnet will host the control plane components of the aks cluster
- **Worker Node Subnet**: This will be the network space for hosting the workder nodes of the cluster

4. Define the output variables which will be accessed later on outside the network module in outputs.tf
- **vnet_id**: This will store the ID of the previously created VNet. This will be used within the cluster module to connect the cluster to the defined VNet. 
- **control_plane_subnet_id**: This will store the ID of the control plane subnet within the VNet. This will be used to specify the subnet where the control plane components of the AKS cluster will be deployed to.
- **worker_node_subnet_id**: This will store the ID of the worker node subnet within the VNet. This will be used to specify the subnet where the worker nodes of the AKS cluster will be deployed to.
- **networking_resource_group_name**:  This will provide the name of the Azure Resource Group where the networking resources were provisioned in. This will be used to ensure the cluster module resources are provisioned within the same resource group.
- **aks_nsg_id**: This will store the ID of the Network Security Group (NSG). This will be used to associate the NSG with the AKS cluster to specify inbound and outboud traffic rules

5. Initialise the network module
    ```
    cd networking-module
    terraform init
    ```


Steps to provisioning the worker nodes component of the aks-cluster
1. create the directory and terraform files: inside the aks-terraform directory

```
  mkdir aks-cluster-module

  cd aks-cluster-module

  touch main.tf outputs.tf variables.tf
```

2. Define the variables to be used to provision the resources in variables.tf
- **aks_cluster_name**: The name of the AKS cluster
- **cluster_location**: The Azure region where the AKS cluster will be deployed
- **dns_prefix**: This defines the DNS prefix of cluster
- **kubernetes_version**: This defines Kubernetes version the cluster will use
- **service_principal_client_id**: This provides the Client ID for the service principal associated with the cluster
- **service_principal_secret**: This provides the Client Secret for the service principal
- **resource_group_name**: this will soecify the address space for the virtual network where the network resources will be placed
- **vnet_id**: this will soecify the address space for the virtual network where the network resources will be placed
- **control_plane_subnet_id**: this will specify the address space for the virtual network where the network resources will be placed
- **worker_node_subnet_id**: this will soecify the address space for the virtual network where the network resources will be placed


3. Define the following resources to be provisioned on azure in main.tf
- **azurerm_kubernetes_cluster**: This will provision the kubernetes cluster on azure. Within the resource, the default_node_pool and service_principal is also defined

4. Define the output variables which will be accessed later on outside the network module in outputs.tf
- **aks_cluster_name**: This will store the name of the provisioned cluster
- **aks_cluster_id**: This will store the ID of the cluster
- **aks_kubeconfig**: This will store the kubernetes configuration file of the cluster. This file is essential for interacting with and managing the AKS cluster using kubectl.

5. Initialise the network module
    ```
    cd aks-cluster-module
    terraform init
    ```

Steps to create the main configuration file
1. Define the terraform block: This specifies the Azure provider and sets the version to 3.0.0
2. Define the provider block: This configures the azure provider. Inside the block, there is the features {} block which is used to enable specific provider features, in this is empty. The client_id, client_secret, subscription_id and tenant_id is generated using the following command
```
  az ad sp create-for-rbac --name myApp --role contributor --scopes /subscriptions/{your-subscription-id}/resourceGroups/{your-resource-group-name}
```
- Replace resource-group-name with a name of a resource group or create one in azure if it doesn't exist
- The **subscription-id** can be found in azure under subscriptions
- The **client_id** is the same as the appID from the generated credentials
- The **client_secret** is the password from the generated credentials
- The **tenent_id** represents the tenant frrom the generated credentials

3. Use the networking module previously created to provision the network resources
- source: The path to the networking module
- define specific values for vairables in the networking module if neccessary

4. Use the AKS Cluster module:
- Define the input variables for the aks cluster which was previously defined in the aks cluster but werent giving specific values
- resource_group_name, vnet_id, control_plane_subnet_id, worker_node_subnet_id, aks_nsg_id represents outputs from the networking module

## Contributors 

- [Junior Edwards](https://github.com/junior451)

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.
