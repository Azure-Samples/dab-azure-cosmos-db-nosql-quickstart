CultureInfo.DefaultThreadCurrentCulture = new CultureInfo("en-US");
WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddSingleton<GraphQLHttpClient>(serviceProvider =>
{
    Configuration configuration = serviceProvider.GetRequiredService<IOptions<Configuration>>().Value;

    string? endpoint = configuration?.DataApiBuilder?.BaseApiUrl;

    if (string.IsNullOrWhiteSpace(endpoint))
    {
        throw new InvalidOperationException("The Data API builder (DAB) endpoint is not configured. Configure the DAB endpoint using the \"CONFIGURATION:DATAAPIBUILDER:BASEAPIURL\" configuration setting.");
    }

    return new GraphQLHttpClient(
        endpoint,
        serializer: new SystemTextJsonSerializer()
    );
});

builder.Services.Configure<Configuration>(
    builder.Configuration.GetSection(nameof(Configuration))
);

builder.Services.AddScoped<IProductsService, DataApiBuilderProductsService>();

WebApplication app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseAntiforgery();

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();