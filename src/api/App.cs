using Azure.Identity;
using Microsoft.Azure.Cosmos;

bool useEmulator = Boolean.Parse(Environment.GetEnvironmentVariable("AZURECOSMOSDB__USEEMULATOR") ?? Boolean.FalseString);
string credential = Environment.GetEnvironmentVariable("AZURECOSMOSDB__CONNECTIONSTRING")!;
ArgumentException.ThrowIfNullOrEmpty(credential);

Console.WriteLine($"[ISEMULATOR]:\t{useEmulator}");
Console.WriteLine($"[CREDENTIAL]:\t{credential}");

using CosmosClient client = useEmulator ?
    GetEmulatorClient(credential) :
    GetServiceClient(credential);

Database database = await client.CreateDatabaseIfNotExistsAsync("cosmicworks");
Container container = await database.CreateContainerIfNotExistsAsync("products", "/id", throughput: 400);

Console.WriteLine($"Azure Cosmos DB container [{container.Id}] created successfully!");

CosmosClient GetEmulatorClient(string connectionString)
{
    CosmosClient client = new CosmosClient(
        connectionString
    );
    return client;
}

CosmosClient GetServiceClient(string endpoint)
{
    // <create_client>
    CosmosClient client = new(
        endpoint,
        new DefaultAzureCredential()
    );
    // </create_client>
    return client;
}