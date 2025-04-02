using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Database.Quality.Disposing;

/// <summary>
///     [Interface] for [Quality] purposes [Disposer] implementations.
/// </summary>
/// <remarks>
///     This Disposer only must be used on [Quality]/[Testing] strictly purposes.
/// </remarks>
public interface IQ_Disposer
    : IDisposer {
}
