using System.Text.Json;
using System.Text.Json.Serialization;

using CSM_Foundation.Advisor.Interfaces;
using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Core.Exceptions;
using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Filters;
using CSM_Foundation.Server.Converters.JSON;
using CSM_Foundation.Server.Enumerators;
using CSM_Foundation.Server.Managers;
using CSM_Foundation.Server.Utils;

using CSM_Security;
using CSM_Security.Entities.Accounts;
using CSM_Security.Entities.Contacts;
using CSM_Security.Entities.Solutions;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Employees;

using TWS_Customer.Managers.Depot;
using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Business;
using TWS_Customer.Services.Interfaces;
using TWS_Customer.Services.Security;
using TWS_Customer.Services.Security.Solutions;

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
    private const string SETTINGS_LOCATION = "\\Properties\\server_properties.json";
    private const string CORS_BLOCK_MESSAGE = "Request blocked by cors, is not part of allowed hosts";

    public static Settings Settings => Settings_ ??= GetSettings();
    private static Settings? Settings_;

    private static void Main(string[] args) {
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

            // --> Data storages connection validations.
            new Database().ValidateConnection();
            new BusinessDatabase().ValidateConnection();

            // --> Adding customer services
            {
                IServiceCollection Services = builder.Services;

                // --> Application
                Services.AddSingleton<DepotManager>();
                Services.AddSingleton<SessionManager>();
                Services.AddSingleton<AnalyticsMiddleware>();
                Services.AddSingleton<AdvisorMiddleware>();
                Services.AddSingleton<FramingMiddleware>();
                Services.AddSingleton<DispositionMiddleware>();
                Services.AddSingleton<IDisposer, SampleDisposer>();

                // --> Databasess contexts
                Services.AddDbContext<Database>();
                Services.AddDbContext<IBusinessDatabase, BusinessDatabase>();

                // --> Depots

                // --> [Business] depots.
                {
                    builder.Services.AddScoped<EmployeesDepot>();
                }

                // --> [Security] depots.
                {
                    Services.AddScoped<IAccountsDepot, AccountsDepot>();
                    Services.AddScoped<ISolutionsDepot, SolutionsDepot>();
                }

                builder.Services.AddScoped<AddressesDepot>();
                builder.Services.AddScoped<UsdotsDepot>();
                builder.Services.AddScoped<CarriersDepot>();
                builder.Services.AddScoped<ApproachesDepot>();
                builder.Services.AddScoped<ContactsDepot>();
                builder.Services.AddScoped<ManufacturersDepot>();
                builder.Services.AddScoped<SituationsDepot>();
                builder.Services.AddScoped<PlatesDepot>();
                builder.Services.AddScoped<TruckDepot>();
                builder.Services.AddScoped<InsurancesDepot>();
                builder.Services.AddScoped<SctsDepot>();
                builder.Services.AddScoped<MaintenacesDepot>();
                builder.Services.AddScoped<StatusesDepot>();
                builder.Services.AddScoped<AddressesDepot>();
                builder.Services.AddScoped<ApproachesDepot>();
                builder.Services.AddScoped<CarriersDepot>();
                builder.Services.AddScoped<DriversDepot>();
                builder.Services.AddScoped<DriversCommonsDepot>();
                builder.Services.AddScoped<DriversExternalsDepot>();
                builder.Services.AddScoped<SectionsDepot>();
                builder.Services.AddScoped<LocationsDepot>();
                builder.Services.AddScoped<LoadTypesDepot>();
                builder.Services.AddScoped<LocationsDepot>();
                builder.Services.AddScoped<TrailerClassesDepot>();
                builder.Services.AddScoped<TrailersCommonsDepot>();
                builder.Services.AddScoped<TrailersExternalsDepot>();
                builder.Services.AddScoped<TrailersDepot>();
                builder.Services.AddScoped<IdentificationsDepot>();
                builder.Services.AddScoped<TrucksExternalsDepot>();
                builder.Services.AddScoped<TrucksCommonsDepot>();
                builder.Services.AddScoped<TrailersTypesDepot>();
                builder.Services.AddScoped<VehiculesModelsDepot>();
                builder.Services.AddScoped<TrucksInventoriesDepot>();
                builder.Services.AddScoped<YardLogsDepot>();
                builder.Services.AddScoped<TrucksHDepot>();

                // --> Services
                builder.Services.AddScoped<ISolutionsService, SolutionsService>();
                builder.Services.AddScoped<IAccountsService, AccountsService>();
                builder.Services.AddScoped<ISecurityService, SecurityService>();
                builder.Services.AddScoped<IManufacturersService, ManufacturersService>();
                builder.Services.AddScoped<ISituationsService, SituationsService>();
                builder.Services.AddScoped<IPlatesService, PlatesServices>();
                builder.Services.AddScoped<ITrucksService, TrucksService>();
                builder.Services.AddScoped<ITrucksExternalsService, TrucksExternalsService>();
                builder.Services.AddScoped<IContactsService, ContactsService>();
                builder.Services.AddScoped<IDriversService, DriversService>();
                builder.Services.AddScoped<IDriversExternalsService, DriversExternalsService>();
                builder.Services.AddScoped<ITrucksExternalsService, TrucksExternalsService>();
                builder.Services.AddScoped<ITrailersService, TrailersService>();
                builder.Services.AddScoped<ITrailersExternalsService, TrailersExternalsService>();
                builder.Services.AddScoped<ILoadTypesService, LoadTypesService>();
                builder.Services.AddScoped<ISectionsService, SectionsService>();
                builder.Services.AddScoped<IYardLogsService, YardLogsService>();
                builder.Services.AddScoped<ICarriersService, CarriersService>();
                builder.Services.AddScoped<IVehiculesModelsService, VehiculeModelService>();
                builder.Services.AddScoped<ITrucksInventoriesService, TruckInventoryService>();
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

