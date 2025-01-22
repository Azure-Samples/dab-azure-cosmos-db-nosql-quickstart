WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddSingleton<GraphQLHttpClient>(serviceProvider =>
{
    Configuration configuration = serviceProvider.GetRequiredService<IOptions<Configuration>>().Value;
    return new GraphQLHttpClient(
        configuration.DataApiBuilder.BaseApiUrl,
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