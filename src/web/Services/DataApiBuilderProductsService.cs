using GraphQL;

namespace Microsoft.Samples.DataApiBuilder.AzureCosmosDBNoSQLQuickstartWeb.Services;

internal sealed class DataApiBuilderProductsService(
    GraphQLHttpClient graphQLClient,
    IOptions<Configuration> configurationOptions
) : IProductsService
{
    private readonly Configuration configuration = configurationOptions.Value;

    public async Task<IEnumerable<Product>> GetProductsAsync()
    {
        var queryRequest = new GraphQLRequest
        {
            Query = """
            query {
              products {
                items {
                id
                name
                description
                sku
                price
                cost
                }
              }
            }
            """
        };

        GraphQLResponse<Payload>? graphQLResponse = await graphQLClient.SendQueryAsync<Payload>(queryRequest);

        if (graphQLResponse?.Errors?.Length > 0)
        {
            throw new InvalidOperationException($"GraphQL query failed. {string.Join(Environment.NewLine, graphQLResponse?.Errors?.Select(error => error.Message) ?? [])}");
        }

        return graphQLResponse?.Data?.Products?.Items ?? [];
    }
}