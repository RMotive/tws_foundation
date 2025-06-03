using System.Text.Json;
using System.Text.Json.Serialization;

using CSM_Foundation.Core;
using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;
using CSM_Foundation.Database.Models;
using CSM_Foundation.Database.Utilitites;
using CSM_Foundation.Logging;
using CSM_Foundation.Server;
using CSM_Foundation.Server.Converters.JSON;

using CSM_Security.Depots;
using CSM_Security.Entities;

using TWS_Business.Depots;
using TWS_Business.Depots.Directories;
using TWS_Business.Depots.Indicators;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Depots.Vehicles.Control;
using TWS_Business.Entities;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Maintenances;
using TWS_Business.Entities.Trailers;

using TWS_Customer.Features.Business;
using TWS_Customer.Features.Security;
using TWS_Customer.Managers.Session;

using TWS_Foundation.Middlewares;

namespace TWS_Foundation;

public class Settings
    : ILoggingObject {
    public required string Tenant { get; init; }
    public required Solution Solution { get; init; }
    public required string Host { get; init; }
    public required string[] Listeners { get; set; }
    public string[] CORS { get; init; } = [];

    public Dictionary<string, object?> Log() {
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
        Logger.Announce("Running [CSM] server engine...");

        try {
            Settings s = Settings;
            Console.Title = $"{s.Solution.Name} | {s.Host}";

            Logger.Success("Server settings loaded", s);

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
                        options.JsonSerializerOptions.Converters.Add(new DateTimeZoneConverter());

                        // --> JSON Converter for [IEntity] objects.
                        options.JsonSerializerOptions.Converters.Add(
                                new EntityConverter(
                                    [
                                        typeof(YardLog),
                                    ]
                                )
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
                                        Logger.Warning(
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
                Services.AddSingleton<AuthManager>();
                Services.AddSingleton<AnalyticsMiddleware>();
                Services.AddSingleton<AdvisorMiddleware>();
                Services.AddSingleton<FramingMiddleware>();
                Services.AddSingleton<DispositionMiddleware>();
                Services.AddSingleton<IDisposer, Disposer>();

                // --> [CSM Security]
                ConnectionOptions securityDbConnectionOptions = DatabaseUtilities.Retrieve(CSM_Security.Database.SIGN);
                new CSM_Security.Database(securityDbConnectionOptions).ValidateConnection();

                Services.AddScoped(
                        (provider) => new CSM_Security.Database(securityDbConnectionOptions)
                    );

                // --> [TWS Business]
                ConnectionOptions businessDbConnectionOptions = DatabaseUtilities.Retrieve(TWS_Business.Database.SIGN);
                new TWS_Business.Database(businessDbConnectionOptions).ValidateConnection();
                Services.AddScoped(
                        (provider) => new TWS_Business.Database(businessDbConnectionOptions)
                    );

                Services.AddScoped<IAccountsDepot, AccountsDepot>();
                Services.AddScoped<ISolutionsDepot, SolutionsDepot>();
                Services.AddScoped<IContactsDepot, ContactsDepot>();
                Services.AddScoped<IFeaturesDepot, FeaturesDepot>();
                Services.AddScoped<ISectionsDepot, SectionsDepot>();
                Services.AddScoped<ISituationsDepot, SituationsDepot>();
                Services.AddScoped<IStatusesDepot, StatusesDepot>();
                Services.AddScoped<IYardLogsDepot, YardLogsDepot>();
                Services.AddScoped<ICarriersDepot, CarriersDepot>();
                Services.AddScoped<ILoadTypesDepot, LoadTypesDepot>();
                Services.AddScoped<IManufacturersDepot, ManufacturersDepot>();
                Services.AddScoped<IPlatesDepot, PlatesDepot>();
                Services.AddScoped<ISCTsDepot, SCTDepot>();
                Services.AddScoped<ITrailerClassesDepot, TrailerClassesDepot>();
                Services.AddScoped<ITrucksDepot, TrucksDepot>();
                Services.AddScoped<IVehiculesModelsDepot, VehiculeModelsDepot>();
                Services.AddScoped<IAddressesDepot, AddressesDepot>();
                Services.AddScoped<IApproachesDepot, ApproachesDepot>();
                Services.AddScoped<IDriversDepot, DriversDepot>();
                Services.AddScoped<IApproachesDepot, ApproachesDepot>();
                Services.AddScoped<IEmployeesDepot, EmployeesDepot>();
                Services.AddScoped<ILocationsDepot, LocationsDepot>();
                Services.AddScoped<IInsuranceDepot, InsurancesDepot>();
                Services.AddScoped<IMaintenanceDepot, MaintenacesDepot>();
                Services.AddScoped<ITrailerClassesDepot, TrailerClassesDepot>();
                Services.AddScoped<ITrailersDepot, TrailersDepot>();
                Services.AddScoped<ITrailersExternal, TrailersExternalsDepot>();
                Services.AddScoped<ITrailerTypesDepot, TrailerTypesDepot>();

                // --> [Customer] services.
                Services.AddScoped<ISecurityService, SecurityService>();
                Services.AddScoped<ISolutionsService, SolutionsService>();
                Services.AddScoped<IAddressesService, AddressesService>();
                Services.AddScoped<ICarriersService, CarriersService>();
                Services.AddScoped<IDriversService, DriversService>();
                Services.AddScoped<IEmployeesService, EmployeesService>();
                Services.AddScoped<ILocationsService, LocationsService>();
                Services.AddScoped<ISectionsService, SectionsService>();
                Services.AddScoped<ITrailerClassesService, TrailerClassesService>();
                Services.AddScoped<ITrailerTypesService, TrailerTypesService>();
                Services.AddScoped<IYardLogsService, YardLogsService>();
                Services.AddScoped<IAccountsService, AccountsService>();
                Services.AddScoped<IContactsService, ContactsService>();
                Services.AddScoped<ILoadTypesService, LoadTypesService>();
                Services.AddScoped<IManufacturersService, ManufacturersService>();
                Services.AddScoped<ISituationsService, SituationsService>();
                Services.AddScoped<IVehiculeModelsService, VehiculeModelsService>();
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
                        Dispose(disposer);
                    }
                    ;
                }
            );
            app.UseCors();

            Logger.Announce($"Server set up ^_____^");
            app.Run();
        } catch (Exception X) when (X is ILoggingException AX) {
            Logger.Exception(AX);
            throw;
        } catch (Exception X) {
            Logger.Exception(new XSystem($"Engine start exception", X));
        } finally {
            Console.WriteLine($"Press any key to close...");
            Console.ReadKey();
        }
    }

    static void Dispose(IDisposer Disposer) {
        Logger.Announce("Disposing quality context records");
        try {
            Disposer.Dispose();
        } catch (Exception X) {
            Logger.Exception(new XSystem("", X));
        }
    }

    static Settings GetSettings() {
        string ws = Directory.GetCurrentDirectory();
        string fp = SETTINGS_LOCATION;
        switch (ServerUtils.Environment) {
            case ServerEnvironments.production:
                fp = fp.Split(".json")[0] + ".production.json";
                break;
            default:
                break;
        }

        string sl = FileUtils.FormatLocation(fp);
        Logger.Note(
            "Retrieving Server settings",
            new Dictionary<string, object?> {
                {"Workspace", ws },
                {"Settings", sl },
                {"Environment", ServerUtils.Environment }
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

