using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;

namespace TWS_Customer.Services.Common.DataManagement.Options;

/// <summary>
/// 
/// </summary>
/// <typeparam name="TSet"></typeparam>
public class ExportViewOptions<TSet>
    where TSet : ISet {

    /// <summary>
    /// 
    /// </summary>
    public required SetViewOptions<TSet> ViewOptions;
}

