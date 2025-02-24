using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

using TWS_Customer.Models.Outs;
using TWS_Customer.Services.Business;

namespace TWS_Customer.Services.Interfaces;

/// <summary>
/// 
/// </summary>
public interface IYardLogsService {

    /// <summary>
    /// s
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    Task<SetViewOut<YardLog>> View(SetViewOptions<YardLog> Options);

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    Task<SetViewOut<YardLog>> ViewInventory(SetViewOptions<YardLog> Options);

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Trucks"></param>
    /// <returns></returns>
    Task<SetBatchOut<YardLog>> Create(YardLog[] Trucks);
    Task<RecordUpdateOut<YardLog>> Update(YardLog YardLog);
    Task<YardLog> Delete(YardLog YardLog);

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    Task<ExportOut> ExportView(SetViewOptions<YardLog> Options);

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    Task<ExportOut> ExportInventory(SetViewOptions<YardLog> Options);
}
