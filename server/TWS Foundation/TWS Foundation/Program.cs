using System.Text.Json;
using System.Text.Json.Serialization;

using CSM_Foundation.Advisor.Interfaces;
using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Core.Exceptions;
using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Filters;
using CSM_Foundation.Database.Models;
using CSM_Foundation.Database.Utilitites;
using CSM_Foundation.Server;
using CSM_Foundation.Server.Converters.JSON;
using CSM_Foundation.Server.Managers;
using CSM_Foundation.Server.Utils;

using CSM_Security;
using CSM_Security.Depots;
using CSM_Security.Entities;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Maintenances;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.USDOTs;

using TWS_Customer.Features.Business;
using TWS_Customer.Features.Security;
using TWS_Customer.Managers.Session;

using TWS_Foundation.Middlewares;

namespace TWS_Foundation;

public class Settings
    : IAdvisingObject {
    public required string Tenant { get; init; }
    public required Solution Solution { get; init; }
    public required string Host { get; init; }
    public required string[] Listeners { get; set; }
    public string[] CORS { get; init; } = [];

    public Dictionary<string, dynamic> Advise() {
        return new() {
            {nameof(Tenant), Tenant },
            {nameof(Solution), $"{Solution.Name} (${Solution.Sign})" },
            {nameof(Host), Host },
            {nameof(Listeners), $"[{string.Join(", ", Listeners)}]" },
            {nameof(CORS), $"[{string.Join(", ", CORS)}]" },
        };
    }
}

public partial class Program {
    const string SETTINGS_LOCATION = "\\Properties\\server_properties.json";
    const string CORS_BLOCK_MESSAGE = "Request blocked by cors, is not part of allowed hosts";

    public static Settings Settings => Settings_ ??= GetSettings();
    static Settings? Settings_;

    static void Main(string[] args) {
        AdvisorManager.Announce("Running engines ◉_◉");

        try {
            Settings s = Settings;
            Console.Title = $"{s.Solution.Name} | {s.Host}";

            AdvisorManager.Success("Server settings loaded", s);

            WebApplicationBuilder builder = WebApplication.CreateBuilder(args);
            // Add services and overriding options to the container.

            builder.Logging.ClearProviders();
            builder.Services.AddControllers()
                .AddJsonOptions(
                    (options) => {
                        options.JsonSerializerOptions.IncludeFields = true;
                        options.JsonSerializerOptions.PropertyNamingPolicy = null;
                        options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;

                        options.JsonSerializerOptions.Converters.Add(new ISetViewFilterConverterFactory());
                        options.JsonSerializerOptions.Converters.Add(new ISetViewFilterNodeConverterFactory());
                        options.JsonSerializerOptions.Converters.Add(new DateTimeWithUTCZoneConverter());

                        // --> JSON Converter for [IEntity] objects.
                        options.JsonSerializerOptions.Converters.Add(
                                new IEntityConvertor {
                                    Variations = [
                                        typeof(YardLog),
                                    ],
                                }
                            );
                    }
                );
            builder.Services.AddCors(
                (CorsOptions) => {
                    CorsOptions.AddDefaultPolicy(
                        (PolicyBuilder) => {
                            PolicyBuilder.AllowAnyHeader();
                            PolicyBuilder.AllowAnyMethod();
                            PolicyBuilder.SetIsOriginAllowed(
                                (Origin) => {
                                    string[] corsPolicies = Settings.CORS;
                                    Uri parsedUrl = new(Origin);

                                    bool isCorsAllowed = corsPolicies.Contains(parsedUrl.Host);
                                    if (!isCorsAllowed) {
                                        AdvisorManager.Warning(
                                            CORS_BLOCK_MESSAGE,
                                            new() {
                                                {nameof(isCorsAllowed), isCorsAllowed},
                                                {nameof(parsedUrl), parsedUrl}
                                            }
                                        );
                                    }
                                    return isCorsAllowed;
                                }
                            );
                        }
                    );
                }
            );

            // --> Adding customer services
            {
                IServiceCollection Services = builder.Services;

                // --> Application
                Services.AddSingleton<SessionManager>();
                Services.AddSingleton<AnalyticsMiddleware>();
                Services.AddSingleton<AdvisorMiddleware>();
                Services.AddSingleton<FramingMiddleware>();
                Services.AddSingleton<DispositionMiddleware>();
                Services.AddSingleton<IDisposer, Disposer>();

                // --> [CSM Security]
                ConnectionOptions securityDbConnectionOptions = DatabaseUtilities.Retrieve(CSM_Security.Database.SIGN);
                Services.AddScoped(
                        (provider) => new CSM_Security.Database(securityDbConnectionOptions)
                    );
                Services.AddScoped<IAccountsDepot, AccountsDepot>();
                Services.AddScoped<ISolutionsDepot, SolutionsDepot>();

                // --> [Customer] services.
                Services.AddScoped<ISecurityService, SecurityService>();
                Services.AddScoped<ISolutionsService, SolutionsService>();
            }

            WebApplication app = builder.Build();
            app.MapControllers();

            // --> Injecting middlewares to Server
            {
                app.UseMiddleware<AnalyticsMiddleware>();
                app.UseMiddleware<AdvisorMiddleware>();
                app.UseMiddleware<FramingMiddleware>();
                app.UseMiddleware<DispositionMiddleware>();
            }

            app.Lifetime.ApplicationStopping.Register(
                () => {
                    using (IServiceScope scope = app.Services.CreateScope()) {
                        IDisposer disposer = scope.ServiceProvider.GetRequiredService<IDisposer>();
                        Dispose(disposer).GetAwaiter().GetResult();
                    }
                    ;
                }
            );
            app.UseCors();

            AdvisorManager.Announce($"Server set up ^_____^");
            app.Run();
        } catch (Exception X) when (X is IAdvisingException AX) {
            AdvisorManager.Exception(AX);
            throw;
        } catch (Exception X) {
            AdvisorManager.Exception(new XSystem(X));
        } finally {
            Console.WriteLine($"Press any key to close...");
            Console.ReadKey();
        }
    }

    static async Task Dispose(IDisposer Disposer) {
        AdvisorManager.Announce("Disposing quality context records");
        try {
            await Disposer.Dispose();
        } catch (Exception X) {
            AdvisorManager.Exception(new XSystem(X));
        }
    }

    static Settings GetSettings() {
        string ws = Directory.GetCurrentDirectory();
        string fp = SETTINGS_LOCATION;
        switch (EnvironmentManager.Mode) {
            case ServerEnvironments.production:
                fp = fp.Split(".json")[0] + ".production.json";
                break;
            default:
                break;
        }

        string sl = FileUtils.FormatLocation(fp);
        AdvisorManager.Note(
            "Retrieving Server settings",
            new Dictionary<string, dynamic> {
                {"Workspace", ws },
                {"Settings", sl },
                {"Environment", EnvironmentManager.Mode }
            }
        );
        string host = ServerUtils.GetHost();
        string[] listeners = Environment.GetEnvironmentVariable("ASPNETCORE_URLS")?.Split(";") ?? [];


        Dictionary<string, dynamic> tmpObject = FileUtils.Deserealize<Dictionary<string, dynamic>>($"{ws}{sl}");
        tmpObject.Add("Host", host);
        tmpObject.Add("Listeners", listeners);

        return JsonSerializer.Deserialize<Settings>(JsonSerializer.Serialize(tmpObject)) ?? throw new Exception($"Wrong [Settings] file format.");
    }
}

