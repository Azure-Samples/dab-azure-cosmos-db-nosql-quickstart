namespace Microsoft.Samples.DataApiBuilder.AzureCosmosDBNoSQLQuickstartWeb.Models;

/// <summary>
/// Represents a product with its details.
/// </summary>
public sealed record Product
{
    /// <summary>
    /// Gets the unique identifier for the product.
    /// </summary>
    public required string Id { get; init; }

    /// <summary>
    /// Gets the name of the product.
    /// </summary>
    public required string Name { get; init; }

    /// <summary>
    /// Gets the description for the product.
    /// </summary>
    public required string Description { get; init; }

    /// <summary>
    /// Gets the stock keeping unit (SKU) for the product.
    /// </summary>
    public required string SKU { get; init; }

    /// <summary>
    /// Gets the list price of the product.
    /// </summary>
    public required decimal Price { get; init; }

    /// <summary>
    /// Gets the actual cost of the product.
    /// </summary>
    public required decimal Cost { get; init; }
}