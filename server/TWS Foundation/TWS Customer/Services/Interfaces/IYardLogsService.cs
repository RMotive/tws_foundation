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

    /// <summary>
    /// 
    /// </summary>
    /// <param name="YardLog"></param>
    /// <param name="updatePivot"></param>
    /// <returns></returns>
    Task<RecordUpdateOut<YardLog>> Update(YardLog YardLog, bool updatePivot);

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Id"></param>
    /// <returns></returns>
    Task<YardLog> Delete(int Id);

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
