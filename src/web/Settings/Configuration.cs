// Copyright (c) Microsoft Corporation. All rights reserved.
namespace Microsoft.Samples.DataApiBuilder.AzureCosmosDBNoSQLQuickstartWeb.Settings;

/// <summary>
/// Represents the configuration settings for the application.
/// </summary>
internal sealed record Configuration
{
    /// <summary>
    /// Gets the Data API builder (DAB) configuration settings.
    /// </summary>
    public required DataApiBuilder DataApiBuilder { get; init; }
}