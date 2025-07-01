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
using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business;
using TWS_Customer.Features.Business.Vehicules;
using TWS_Customer.Features.Security;
using TWS_Customer.Managers.Auth;

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
                                        typeof(LoadType),
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
                IServiceCollection services = builder.Services;



                // --> Application
                services.AddHttpContextAccessor();
                services.AddSingleton<IAuthManager, AuthManager>();
                services.AddSingleton<AnalyticsMiddleware>();
                services.AddSingleton<AdvisorMiddleware>();
                services.AddSingleton<FramingMiddleware>();
                services.AddSingleton<DispositionMiddleware>();
                services.AddSingleton<IDisposer, Disposer>();

                // --> [CSM Security]
                ConnectionOptions securityDbConnectionOptions = DatabaseUtilities.Retrieve(CSM_Security.Database.SIGN);
                new CSM_Security.Database(securityDbConnectionOptions).ValidateConnection();

                services.AddScoped(
                        (provider) => new CSM_Security.Database(securityDbConnectionOptions)
                    );

                // --> [TWS Business]
                ConnectionOptions businessDbConnectionOptions = DatabaseUtilities.Retrieve(TWS_Business.Database.SIGN);
                new TWS_Business.Database(businessDbConnectionOptions).ValidateConnection();
                services.AddScoped(
                        (provider) => new TWS_Business.Database(businessDbConnectionOptions)
                    );

                services.AddScoped<IAccountsDepot, AccountsDepot>();
                services.AddScoped<ISolutionsDepot, SolutionsDepot>();
                services.AddScoped<IContactsDepot, ContactsDepot>();
                services.AddScoped<IFeaturesDepot, FeaturesDepot>();
                services.AddScoped<ISectionsDepot, SectionsDepot>();
                services.AddScoped<ISituationsDepot, SituationsDepot>();
                services.AddScoped<IStatusesDepot, StatusesDepot>();
                services.AddScoped<IYardLogsDepot, YardLogsDepot>();
                services.AddScoped<ICarriersDepot, CarriersDepot>();
                services.AddScoped<ILoadTypesDepot, LoadTypesDepot>();
                services.AddScoped<IManufacturersDepot, ManufacturersDepot>();
                services.AddScoped<IPlatesDepot, PlatesDepot>();
                services.AddScoped<ISCTsDepot, SCTDepot>();
                services.AddScoped<ITrailerClassesDepot, TrailerClassesDepot>();
                services.AddScoped<TrucksDepot, TrucksDepot>();
                services.AddScoped<IVehiculesModelsDepot, VehiculeModelsDepot>();
                services.AddScoped<IAddressesDepot, AddressesDepot>();
                services.AddScoped<IApproachesDepot, ApproachesDepot>();
                services.AddScoped<DriversDepot, DriversDepot>();
                services.AddScoped<IApproachesDepot, ApproachesDepot>();
                services.AddScoped<IEmployeesDepot, EmployeesDepot>();
                services.AddScoped<ILocationsDepot, LocationsDepot>();
                services.AddScoped<IInsuranceDepot, InsurancesDepot>();
                services.AddScoped<IMaintenanceDepot, MaintenacesDepot>();
                services.AddScoped<ITrailerClassesDepot, TrailerClassesDepot>();
                services.AddScoped<TrailersDepot, TrailersDepot>();
                services.AddScoped<ITrailerTypesDepot, TrailerTypesDepot>();
                services.AddScoped<IWaypointsDepot, WaypointsDepot>();

                // --> [Customer] services.
                services.AddScoped<ISecurityService, SecurityService>();
                services.AddScoped<ISolutionsService, SolutionsService>();
                services.AddScoped<ISolutionsService, SolutionsService>();
                services.AddScoped<IAddressesService, AddressesService>();
                services.AddScoped<ICarriersService, CarriersService>();
                services.AddScoped<IDriversCommonService, DriversService>();
                services.AddScoped<IEmployeesService, EmployeesService>();
                services.AddScoped<ILocationsService, LocationsService>();
                services.AddScoped<ISectionsService, SectionsService>();
                services.AddScoped<ITrailerClassesService, TrailerClassesService>();
                services.AddScoped<ITrailerTypesService, TrailerTypesService>();
                services.AddScoped<IYardLogsService, YardLogsService>();
                services.AddScoped<IAccountsService, AccountsService>();
                services.AddScoped<IContactsService, ContactsService>();
                services.AddScoped<ILoadTypesService, LoadTypesService>();
                services.AddScoped<IManufacturersService, ManufacturersService>();
                services.AddScoped<ISituationsService, SituationsService>();
                services.AddScoped<IVehiculeModelsService, VehiculeModelsService>();
                services.AddScoped<ITrucksCommonService, TrucksService>();
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

