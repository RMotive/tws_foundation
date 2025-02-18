using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Database.Quality.Disposing;

/// <summary>
///     [Interface] for [Quality] purposes [Disposer] implementations.
/// </summary>
/// <remarks>
///     This Disposer only must be used on [Quality]/[Testing] strictly purposes.
/// </remarks>
public interface IQ_Disposer {

    /// <summary>
    ///     Pushes the given <paramref name="Record"/> into the Disposing queue.
    /// </summary>
    /// <param name="Record">
    ///     Database stored record to dispose.
    /// </param>
    /// <remarks>
    ///     Mind that the disposing order is FILO (Reverse).
    /// </remarks>
    void Push(IEntity Record);

    /// <summary>
    ///     Pushes the given <paramref name="Records"/> into the Disposing queue.
    /// </summary>
    /// <param name="Records">
    ///     Database stored records to dispose.
    /// </param>
    /// <remarks>
    ///     Mind that the disposing order is FILO (Reverse).
    /// </remarks>
    void Push(IEntity[] Records);

    /// <summary>
    ///     Instruction to execute the disposing operation.
    /// </summary>
    void Dispose();
}
