using ClosedXML.Excel;

using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Models.Outs;
using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;

/// <summary>
/// 
/// </summary>
public class YardLogsService
    : IYardLogsService {

    /// <summary>
    /// 
    /// </summary>
    private readonly YardLogsDepot YardLogs;

    /// <summary>
    /// 
    /// </summary>
    /// <param name="YardLogs"></param>
    public YardLogsService(
       YardLogsDepot YardLogs) {

        this.YardLogs = YardLogs;

    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="query"></param>
    /// <returns></returns>
    private IQueryable<YardLog> Include(IQueryable<YardLog> query) {
        return query
            .Include("Driver.Internal.Identification")
            .Include("Driver.External.Identification")
            .Include("Trailer.External.TrailerType.TrailerClass")
            .Include("Trailer.Internal.TrailerType.TrailerClass")
            .Include("Trailer.Internal.Carrier.Address")
            .Include("Trailer.Internal.Carrier.USDOT")
            .Include("Trailer.Internal.Carrier.Approach")
            .Include("Model")
            .Include("Truck.Model")
            .Include("Truck.External")
            .Include("Truck.Internal.Carrier.Address")
            .Include("Truck.Internal.Carrier.USDOT")
            .Include("Truck.Internal.Carrier.Approach")
            .Include("Section.Location");
    }


    public async Task<SetViewOut<YardLog>> View(SetViewOptions<YardLog> options) {

        return await YardLogs.View(options, Include);
    }

    public async Task<SetBatchOut<YardLog>> Create(YardLog[] yardLog) {
        return await YardLogs.Create(yardLog);
    }
    public async Task<EntityUpdateOut<YardLog>> Update(YardLog yardLog, bool updatePivot = false) {

        return await YardLogs.Update(yardLog, Include);
    }

    public async Task<YardLog> Delete(int Id) {
        return await YardLogs.Delete(Id);
    }

    public Task<SetViewOut<YardLog>> ViewInventory(SetViewOptions<YardLog> Options) {
        return YardLogs.ViewInventory(Options);
    }

    public async Task<ExportOut> ExportView(SetViewOptions<YardLog> Options) {
        (string, string, Func<YardLog, string?>)[] exportFields = [
            ("ID", "A", (i) => i.Id.ToString()),
            ("Tipo de Registro", "B", (i) => i.Entry ? "Entrada" : "Salida"),
            ("Fecha", "C", (i) => $"{i.Timestamp.ToShortDateString()} {i.Timestamp.ToShortTimeString()} UTC"),
            ("Tipo de Carga", "D", (i) => i.LoadType.Name ),
            ("Licencia del Conductor", "E", (i) => i.Driver.License),
            ("Nombre del Conductor", "F", (i) => i.Driver.Name),
            ("Número de Camión", "G", (i) => i.Truck.Economic),
            ("Placa del Camión", "H", (i) => i.Truck.PlateUSA ?? i.Truck.PlateMEX),
            ("Número de Remolque", "I", (i) => i.Trailer?.Economic),
            ("Placa del Remolque", "J", (i) => i.Trailer?.PlateMEX ?? i.Trailer?.PlateUSA),
            ("Número de Sello", "K", (i) => i.Seal),
            ("Número de Sello #2", "L", (i) => i.SealAlt),
            ("Desde / Hacia", "M", (i) => i.FromTo),
            ("Daño", "N", (i) => i.Damage?.Length != 0 ? "Dañado" : "Ninguno"),
            ("Sección", "O", (i) => i.Section.Display),
            ("Guardia", "P", (i) => i.Guard.Identification.Name)
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

        Options.Export = true;
        SetViewOut<YardLog> viewOut = await YardLogs.ViewInventory(Options);
        for (int recordPointer = 0; recordPointer < viewOut.Records.Length; recordPointer++) {
            YardLog record = viewOut.Records[recordPointer];

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

        AdvisorManager.Success(
                "Excel file export",
                new Dictionary<string, dynamic> {
                    { "Path", tempFileStore },
                }
            );

        return new ExportOut {
            Content = reader.ReadBytes((int)fileStream.Length),
            Name = $"YardLog Inventory ({DateTime.UtcNow.ToShortDateString()})",
            Extension = ExportOutExtensions.XLSX
        };
    }

    public async Task<ExportOut> ExportInventory(SetViewOptions<YardLog> Options) {
        (string, string, Func<YardLog, string?>)[] exportFields = [
            ("Trailer NO", "A", (YardLog i) => i.Trailer?.Economic),
            ("Placa USA", "B", (YardLog i) => i.Trailer?.PlateUSA),
            ("Placa MEX", "C", (YardLog i) => i.Trailer?.PlateMEX),
            ("Truck NO.", "D", (YardLog i) => i.Truck.Economic),
            ("Truck Placa USA", "E", (YardLog i) => i.Truck.PlateUSA),
            ("Truck Placa MEX", "F", (YardLog i) => i.Truck.PlateMEX),
            ("Entrada", "G", (YardLog i) => $"{i.Timestamp.ToShortDateString()} {i.Timestamp.ToShortTimeString()} UTC"),
            ("Sección", "H", (YardLog i) => i.Section.Display),
            ("Compañía", "I", (YardLog i) => i.Trailer?.Carrier),
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

        Options.Export = true;
        SetViewOut<YardLog> viewOut = await YardLogs.ViewInventory(Options);
        for (int recordPointer = 0; recordPointer < viewOut.Records.Length; recordPointer++) {
            YardLog record = viewOut.Records[recordPointer];

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

        AdvisorManager.Success(
                "Excel file export",
                new Dictionary<string, dynamic> {
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