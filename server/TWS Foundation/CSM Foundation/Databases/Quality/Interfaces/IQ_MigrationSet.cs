﻿namespace CSM_Foundation.Databases.Quality.Interfaces;

/// <summary>
///     Interface Quality for [Q_Entity].
///     
///     Defines what quality operations must be performed by a [Q_Entity].
///     
///     [Q_Entity] concept: determines a quality implementation to qualify 
///     a [MigrationDatabases] [Entity] implementation.
/// </summary>
public interface IQ_MigrationSet {
    /// <summary>
    ///     Qualifies:
    ///         - [Entity] EvaluateRead success.
    ///         - [Entity] EvaluateRead fails.
    /// </summary>
    public void Evaluate();
}
