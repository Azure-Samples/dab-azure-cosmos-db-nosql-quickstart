using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Microsoft.Extensions.Options;
using DAB.Samples.AzureCosmosDBNoSQL.Quickstart.Web;
using DAB.Samples.AzureCosmosDBNoSQL.Quickstart.Web.Options;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

builder.Services.AddOptions<DataApiBuilder>(nameof(DataApiBuilder));

builder.Services.AddScoped(serviceProvider =>
{
    var options = serviceProvider.GetRequiredService<IOptions<DataApiBuilder>>().Value;
    ArgumentException.ThrowIfNullOrEmpty(options.Endpoint, nameof(options.Endpoint));
    var client = new HttpClient { BaseAddress = new Uri(options.Endpoint) };
    return client;
});

await builder.Build().RunAsync();
