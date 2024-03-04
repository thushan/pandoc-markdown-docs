# Mater AI Technical Overview

## Proof of Concept Deployment

For the proof-of-concept, a "start small and expand" approach will be taken for the architecture of the Azure deployment. This is a recommended methodology based on the Microsoft Cloud Adoption Framework (CAF) which provides a high quality starting point for a cloud service, minimising the initial costs, and allowing for future growth.

This implementation option creates a single landing zone, in which resources are organised into workloads defined by specific resource groups. Choosing this minimalist approach to resource organisation defers the technical decision of resource organization.

## Azure AI Services

To demonstrate the use of Azure AI services to Mater and what's possible with data from CROP to determine items missed in a Clinical Coding Summary,  we will be leveraging the [Azure AI Studio](https://ai.azure.com) throughout the PoC to provision core services including but not limited to:

- Azure AI Search
- Azure Computer Vision
- Azure OpenAI
- Azure Functions
- Azure AppService + AppService Plan
- Storage accounts
- Keyvault

They will be organised within the Azure AI Hub for the Mater project running under Australia East.

## Logging and Monitoring

Azure Monitor and Application Insights workspace will be configured to capture system and application logs and metrics to assist with diagnosing any issues with the system.  

Application Insights can also be configured to capture application usage data on the users of the system.

## Networking 

Configuration of Azure Virtual Network (VNET) and other required services such as DNS hosting etc. The configuration of a VNET, though not essential, is a beneficial future-proofing step should there be a future need to integrate with other corporate network or SaaS products at an enterprise level.

## Identity

Configuration of Azure Entra (Active Directory), including Roles & Groups for development and operations personnel.

## Policy, Naming & Tagging

Foundational Azure Policies will be implemented for tagging of resources and other basic governance requirements. Resource tagging is important for cloud cost management as it allows tools such as CloudCtrl to accurately break down cloud spend by resource type, or environment.

## Resource Groups

Workloads will be grouped into Azure Resource Groups. Generally these would be shared resources, dev/test environment resources, and production resources.  The separation of the workloads into separate groups makes it easier to allocate permissions to groups of users based on job role. For example, developers can be allocated full access to the development resource group, but not production.

Within AI Studio, we will select an appropriate PoC signified resource group `mater-ai-coding-poc`.

## Data

Data is stored on a storage containers secured and locked down to avoid leaking of private and highly-sensitive patient data. Data stored on the containers are also encrypted and restricted by default.

Furthermore, we ensure that any data stored in the `data` container, does not contain any patient details (such as their name) and reference only the URN, EpisodeID and PatientID which are required for the LLM to determine age related requirements or stay related requirements or prior episode histories for patients.

## Storage and Secrets Management

Azure Blob Storage will be used for the storage of images (scanned documents), PDFs, structured and unstructured documents. This is a scalable platform allowing data to be migrated to lower-cost tiers in the future if required.

Azure KeyVault will be deployed to provide secure storage for any sensitive data required by the system such as database connection information, or API Keys required to access third-party services.

## Cost Management

Through the use of resource tagging applied in previous steps, the Azure Cost Management portal (included in Azure) can be used to view high-level costs.  

However, we recommend the use of CloudCtrl, a product built by a SixPivot company, to gain deeper insights, provide proactive monitoring, and offer recommendations for cloud spend optimisation.

## Compute

Compute for the AI Services will be provisioned via AI Studio and utilise best effort cost to benefit marker and ensure that we minimise overruns during the PoC. Compute will largely depend on the models we select based on the parameters we intend demo or prove with our hypothesis.

## Automation

To ensure a robust and repeatable process, we will create a series of reusable artifacts based on the Azure Landing Zone templates. These will be created using the [Bicep](https://learn.microsoft.com/en-us/azure/architecture/landing-zones/bicep/landing-zone-bicep) tool, the Microsoft recommended tool of choice for Azure automation tasks.

We will also configure the Azure Devops application repositories to automatically build and publish new versions of the applications through the GitHub Actions pipeline feature. This will enable developers to seamlessly release software changes into the test environment without the need for manual intervention. 

This process can be further enhanced to deploy application changes into production through a business approval process.

## Cloud Costs

To undertake the PoC and the required services on Azure, we've calculated the costs via the Azure Cost Calculator.

We understand that as a PoC, the lifetime of this may not extend beyond the validation stage.

Proof of Estimate Cost per Month is approximated in AUD.

* Mater AI Prompt: AUD$581
* Mater AI Tuned Playground: AUD$922

All pricing has been specified in USD and for the Australia East region for specific services.

### Azure AI Services

For most of the Azure AI Services used within the Proof of Concept, the lowest applicable tier has been selected. When productionising Mater AI Platform, appropriate tiers can be selected and deployed by configuring the `mater-ai-poc-parameters.json` file.

#### Azure Open AI Service

**Latest Pricing:** [Azure OpenAI Pricing Table](https://azure.microsoft.com/en-au/pricing/details/cognitive-services/openai-service/#pricing) (March 2024)

**SKU:** `S0`

The Azure OpenAI Service contains two of the primary models used by the PoC.

* GPT-3.5 Turbo (0613) 16K | Input: $0.0005 / Output: $0.0015 (per 1000 tokens)
* GPT-4 (0613) 32K | Input: $0.06 / Output: $0.12 (per 1000 tokens)

We forecast with our current Proof of Concept, with default medical summaries on average evelope of $0.56 per coding and $0.72 per review.

#### Azure AI Computer Vision

**Latest Pricing:** [Azure Computer Vision Pricing Table](https://azure.microsoft.com/en-au/pricing/details/cognitive-services/computer-vision/#pricing) (March 2024)

**SKU:** `F0`

Azure AI Computer Vision is used for OCR on patient records and summaries and for the proof of Concept, we're utilising the Free tier which affords 5,000 free conversions at a rate of 20 per minute.

#### Azure AI Search
**Latest Pricing:** [Azure AI Search Pricing Table](https://azure.microsoft.com/en-au/pricing/details/search/#pricing) (March 2024)

**SKU:** `S1`

Azure AI Search is used as a vector store for embeddings in the RAG implementation of Mater AI. For the proof of concept, our needs required at minimum, `Standard S1` which costs around $0.45/hr or USD$324.12/month giving us 25GB of Storage, 50 Indexes and 36 scale outs.

We believe this should be the minimum starting point for production based on data load, query load and requirements determined to be important.