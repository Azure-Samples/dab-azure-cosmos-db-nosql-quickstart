# Quickstart: Data API builder and Azure Cosmos DB for NoSQL

This is a Blazor web application that illustrates using Data API builder with Azure Cosmos DB for NoSQL. This sample application uses a Blazor WebAssembly front-end to access an Azure Cosmos DB for NoSQL account using the [Data API builder](https://learn.microsoft.com/azure/data-api-builder) container image.

This template illustrates these practices:

- Using a user-assigned managed identity to connect hosting and database services
  - Using managed identity to connect Azure Container Apps containers to an Azure Cosmos DB for NoSQL account
  - Assigning managed identity as the admin for the Azure Cosmos DB for NoSQL account
- Deploying a AdventureWorks-derived sample database to Azure Cosmos DB for NoSQL
- Disabling local and key-based authentication to Azure Cosmos DB for NoSQL

## Prerequisites

> This template will create infrastructure and deploy code to Azure. If you don't have an Azure Subscription, you can sign up for a [free account here](https://azure.microsoft.com/free/). Make sure you have the contributor role in the Azure subscription.

The following prerequisites are required to use this application. Please ensure that you have them all installed locally.

- [Azure Developer CLI](https://aka.ms/azd-install)
- [.NET SDK 8.0](https://dotnet.microsoft.com/download/dotnet/8.0)

## Get started

Follow these steps to authenticate to Azure, initialize thetemplate, provision infrastructure in Azure, and deploy the code to Azure.

1. Log in to azd. Only required once per-install.

    ```shell
    azd auth login
    ```

1. Run the first-time project setup. Initialize a project in the current directory, using this template.

    ```shell
    azd init --template dab-azure-cosmos-db-nosql-quickstart
    ```

    > [!NOTE]
    > Omit the --template argument if you are running in a development container.

1. Provision the resources in Azure and deploy the application code.

    ```shell
    azd up
    ```

1. Navigate to the running web application.

    > [!TIP]
    > Azure Developer CLI will output the URL of the web application after deployment.

    ![Screenshot of the running web application on Azure Container Apps.](media/running-application.png)

## Application Architecture

This application utilizes the following Azure resources:

- [**Azure Container Apps**](https://learn.microsoft.com/azure/container-apps/)
    - This service hosts the ASP.NET Blazor WebAssembly web application
    - This service also hosts the Data API builder container
- [**Azure Cosmos DB for NoSQL**](https://learn.microsoft.com/azure/cosmos-db/nosql/) 
    - This service stores the NoSQL data

Here's a high level architecture diagram that illustrates these components. Notice that these are all contained within a single **resource group**, that will be created for you when you create the resources.

```mermaid
%%{ init: { 'theme': 'base', 'themeVariables': { 'background': '#243A5E', 'primaryColor': '#50E6FF', 'primaryBorderColor': '#243A5E', 'tertiaryBorderColor': '#50E6FF', 'tertiaryColor': '#243A5E', 'fontFamily': 'Segoe UI', 'lineColor': '#FFFFFF', 'primaryTextColor': '#243A5E', 'tertiaryTextColor': '#FFFFFF' } }}%%
flowchart TB
    subgraph web-app[Azure Container Apps]
        app-framework([.NET 8 - Blazor WASM])
    end
    subgraph data-api-builder[Azure Container Apps]
        api-framework[[Data API builder]]
    end
    subgraph azure-cosmos-db-nosql[Azure Cosmos DB for NoSQL]
        subgraph database-cosmicworks[Database: CosmicWorks]
            subgraph container-products[Container: Products]
            end
        end
    end
    web-app --> data-api-builder
    data-api-builder --> azure-cosmos-db-nosql
```

## Cost of provisioning and deploying this template

This template provisions resources to an Azure subscription that you will select upon provisioning them. Refer to the [Pricing calculator for Microsoft Azure](https://azure.microsoft.com/pricing/calculator/) to estimate the cost you might incur when this template is running on Azure and, if needed, update the included Azure resource definitions found in [`infra/main.bicep`](infra/main.bicep) to suit your needs.

## Tooling

This template is structured using the [Azure Developer CLI](https://aka.ms/azure-dev/overview). You can learn more about `azd` architecture in [the official documentation](https://learn.microsoft.com/azure/developer/azure-developer-cli/make-azd-compatible?pivots=azd-create#understand-the-azd-architecture).

## Next steps

At this point, you have a complete application deployed on Azure. But there is much more that the Azure Developer CLI can do. These next steps will introduce you to additional commands that will make creating applications on Azure much easier.

- [`azd down`](https://learn.microsoft.com/azure/developer/azure-developer-cli/reference#azd-down) - to delete all the Azure resources created with this template 