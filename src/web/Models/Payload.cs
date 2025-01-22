namespace Microsoft.Samples.DataApiBuilder.AzureCosmosDBNoSQLQuickstartWeb.Models;

/// <summary>
/// Represents a payload of data.
/// </summary>
public sealed record Payload
{
    /// <summary>
    /// Gets the value of the payload.
    /// </summary>
    public required ProductsPayload Products { get; init; }
}

/// <summary>
/// Represents a payload of <see cref="Product"/> data.
/// </summary>
public sealed record ProductsPayload
{
    /// <summary>
    /// Gets the value of the payload.
    /// </summary>
    public required List<Product> Items { get; init; }
}
