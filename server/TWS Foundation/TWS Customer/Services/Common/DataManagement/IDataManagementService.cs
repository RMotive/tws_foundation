using CSM_Foundation.Database.Entity;

using TWS_Customer.Services.Common.DataManagement.Params;

namespace TWS_Customer.Services.Common.DataManagement;

/// <summary>
/// 
/// </summary>
public interface IDataManagementService {

    /// <summary>
    ///     
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    string ExportView(ExportViewParams<IEntity> Options);
}
