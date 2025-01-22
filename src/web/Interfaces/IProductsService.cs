namespace Microsoft.Samples.DataApiBuilder.AzureCosmosDBNoSQLQuickstartWeb.Interfaces;

internal interface IProductsService
{
    Task<IEnumerable<Product>> GetProductsAsync();
}
