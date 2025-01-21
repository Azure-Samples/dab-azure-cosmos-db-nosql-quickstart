namespace Microsoft.Samples.DataApiBuilder.AzureCosmosDBNoSQLQuickstartWeb.Models;

/// <summary>
/// Represents a product with its details.
/// </summary>
public sealed record Product
{
    /// <summary>
    /// Gets the unique identifier for the product.
    /// </summary>
    public required int ProductID { get; init; }

    /// <summary>
    /// Gets the name of the product.
    /// </summary>
    public required string Name { get; init; }

    /// <summary>
    /// Gets the product number.
    /// </summary>
    public required string ProductNumber { get; init; }

    /// <summary>
    /// Gets the list price of the product.
    /// </summary>
    public required decimal ListPrice { get; init; }

    /// <summary>
    /// Gets the date when the product starts selling.
    /// </summary>
    public required DateTime SellStartDate { get; init; }
}