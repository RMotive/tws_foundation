using ClosedXML.Excel;

using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Depots.Models;

using CSM_Foundation.Logging;
using CSM_Foundation.Product;

using CSM_Security.Entities;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots.Vehicles.Control;
using TWS_Business.Entities;

using TWS_Customer.Models.Outs;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="YardLog"/> based [Service] implementations. 
/// </summary>
public interface IYardLogsService
    : IService<YardLog> {

    /// <summary>
    ///     Generates a Inventory View of <see cref="YardLog"/>, filtered by trailers.
    /// </summary>
    /// <param name="input">
    ///     <see cref="QueryInput{TEntity, TParameters}"/> data.
    /// </param>
    /// <returns>
    ///     <see cref="ViewOutput{TEntity}"/> data.
    /// </returns>
    Task<ViewOutput<YardLog>> InventoryTrailerView(QueryInput<YardLog, ViewInput<YardLog>> input);

    /// <summary>
    ///     Generates a file View of <see cref="YardLog"/>, based on input parameters.
    /// </summary>
    /// <param name="input">
    ///     <see cref="QueryInput{TEntity, TParameters}"/> data.
    /// </param>
    /// <returns>
    ///     <see cref="ViewOutput{TEntity}"/> data.
    /// </returns>
    Task<ExportOut> ExportView(QueryInput<YardLog, ViewInput<YardLog>> input);
}

/// <summary>
///     [Service] native implementation for <see cref="YardLog"/> based operations.
/// </summary>
public class YardLogsService
    : BService<YardLog, IYardLogsDepot>, IYardLogsService {

    CSM_Security.Database _securityDb;
    private static QueryProcessor<YardLog> QueryProcessor(CSM_Security.Database securityDb) => (sourceQuery) => {
        /// Get the vendors in a dictionary to avoid multiple queries when processing the postprocessor.
        var vendorsDictionary = securityDb.Vendors.ToDictionary(v => v.Id);

        sourceQuery = sourceQuery
            .Include(e => e.Resources)
            .Include(e => e.Guard).ThenInclude(e => e.Approach)
            .Include(e => e.Guard).ThenInclude(e => e.Address)
            .Include(e => e.Section).ThenInclude(e => e.Resource)
            .Include(e => e.LoadType)
            .Include(e => e.Driver)
            .Include(e => e.Truck)
            .Include(e => e.Trailer)
            .Include(e => e.Vendors);
         sourceQuery =
            from y in sourceQuery
            select new YardLog {
                Id = y.Id,
                Entry = y.Entry,
                Reservation = y.Reservation,
                Seal = y.Seal,
                SealAlt = y.SealAlt,
                FromTo = y.FromTo,
                LoadType = y.LoadType,
                Guard = y.Guard,
                Section = y.Section,
                Driver = y.Driver,
                Truck = y.Truck,
                Trailer = y.Trailer,
                Resources = y.Resources,
                Vendors = (ICollection<YardLogVendor>)y.Vendors.Select(link => new YardLogVendor {
                    VendorId = link.VendorId,
                    YardlogId = link.YardlogId,
                    Yardlog = link.Yardlog,
                    Vendor = vendorsDictionary.ContainsKey(link.VendorId)
                        ? vendorsDictionary[link.VendorId]
                        : null!
                })
            };

        return sourceQuery;
    };

    /// <summary>
    ///     Creates a new <see cref="YardLogsService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="YardLog"/> based <see cref="IDepot{TEntity}"/> handler to be used
    /// </param>
    public YardLogsService(CSM_Security.Database _securityDb, IYardLogsDepot Depot) : base(Depot) { 
        this._securityDb = _securityDb;
    }
    public async override Task<ViewOutput<YardLog>> View(QueryInput<YardLog, ViewInput<YardLog>> input) {
        input.PostProcessor = QueryProcessor(_securityDb);
        return await depot.View(input);
    }

    public async Task<ViewOutput<YardLog>> InventoryTrailerView(QueryInput<YardLog, ViewInput<YardLog>> input) {
        input.PreProcessor = (query) => {
            return query
            .Include(e => e.Guard).ThenInclude(e => e.Approach)
            .Include(e => e.Guard).ThenInclude(e => e.Address)
            .Include(e => e.Section).ThenInclude(e => e.Resource)
            .Include(e => e.LoadType)
            .Include(e => e.Driver)
            .Include(e => e.Truck)
            .Include(e => e.Trailer);
        };

        input.PostProcessor = (query) => {
            // Get the last entry for every trailer in yardlogs.
            var lastPerTrailer = query
                .Where(i => i.Trailer != null)
                .GroupBy(i => i.Trailer!.Id)
                .Select(g => new { Trailer = g.Key, MaxTimestamp = g.Max(x => x.Timestamp) });

            // Join the previous trailers results.
            var lastLogsQuery = from l in lastPerTrailer
                                join y in query.Where(i => i.Trailer != null)
                                  on new { Trailer = l.Trailer, Timestamp = l.MaxTimestamp }
                                  equals new { Trailer = y.Trailer!.Id, Timestamp = y.Timestamp }
                                select y;

            return lastLogsQuery
                .OrderByDescending(y => y.Timestamp)
                .AsQueryable();

        };

        return await depot.View(input);
    }

    public async Task<ExportOut> ExportView(QueryInput<YardLog, ViewInput<YardLog>> input) {
        input.PostProcessor = QueryProcessor(_securityDb);
        (string, string, Func<YardLog, string?>)[] exportFields = [
           ("Trailer NO", "A", (YardLog i) => i.Trailer?.Economic),
            ("Placa USA", "B", (YardLog i) => i.Trailer?.PlateUSA),
            ("Placa MEX", "C", (YardLog i) => i.Trailer?.PlateMEX),
            ("Truck NO.", "D", (YardLog i) => i.Truck.Economic),
            ("Truck Placa USA", "E", (YardLog i) => i.Truck.PlateUSA),
            ("Truck Placa MEX", "F", (YardLog i) => i.Truck.PlateMEX),
            ("Entrada", "G", (YardLog i) => $"{i.Timestamp.ToShortDateString()} {i.Timestamp.ToShortTimeString()} UTC"),
            ("Sección", "H", (YardLog i) => i.Section.Display),
            ("Compañía", "I", (YardLog i) => i.Truck.Internal?.Carrier?.Name ?? i.Truck.External?.Carrier),
            ("Posesión", "J", (YardLog i) => i.Truck.Internal != null ? "Interno" : i.Truck?.External != null ? "Externo" : "No Identificable"),
        ];

        string tempFileStore = $"{Path.GetTempPath()}yardlog_export_{Guid.NewGuid()}.xlsx";

        using XLWorkbook book = new();
        using FileStream fileStream = new(tempFileStore, FileMode.OpenOrCreate);


        IXLWorksheet bookSheet = book.Worksheets.Add("YardLog Inventory");

        DateTime timestamp = DateTime.UtcNow;
        IXLCell titleCell = bookSheet.Cell("A1");
        IXLCell timeCell = bookSheet.Cell("B1");

        titleCell.Value = "YardLog Inventory";
        titleCell.Style.Fill.BackgroundColor = XLColor.AshGrey;

        timeCell.Value = $"{timestamp.ToShortDateString()} {timestamp.ToShortTimeString()} (UTC)";

        ViewOutput<YardLog> viewOut = await InventoryTrailerView(input);
        for (int recordPointer = 0; recordPointer < viewOut.Entities.Length; recordPointer++) {
            YardLog record = viewOut.Entities[recordPointer];

            foreach ((string, string Column, Func<YardLog, string?> ComposeValue) field in exportFields) {

                bookSheet.Cell($"{field.Column}{3 + recordPointer}").Value = field.ComposeValue(record) ?? "";
            }
        }

        foreach ((string Name, string Column, Func<YardLog, string?>) field in exportFields) {

            IXLCell fieldCell = bookSheet.Cell($"{field.Column}2");

            fieldCell.Value = field.Name;
            fieldCell.Style.Fill.BackgroundColor = XLColor.AshGrey;
            fieldCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

            bookSheet.Column(field.Column).AdjustToContents();
        }

        book.SaveAs(fileStream);
        fileStream.Position = 0;

        using BinaryReader reader = new(fileStream);

        Logger.Success(
                "Excel file export",
                new Dictionary<string, object?> {
                    { "Path", tempFileStore },
                }
            );

        return new ExportOut {
            Content = reader.ReadBytes((int)fileStream.Length),
            Name = $"YardLog Inventory ({DateTime.UtcNow.ToShortDateString()})",
            Extension = ExportOutExtensions.XLSX
        };
    }
}
