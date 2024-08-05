namespace DAB.Samples.AzureCosmosDBNoSQL.Quickstart.Web.Models;

public record Product(
    int ProductID,
    string Name,
    string ProductNumber,
    decimal ListPrice,
    DateTime SellStartDate
);