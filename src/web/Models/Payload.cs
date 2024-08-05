namespace DAB.Samples.AzureCosmosDBNoSQL.Quickstart.Web.Models;

public record Payload<T>(
    IEnumerable<T> Value,
    Uri NextLink
);