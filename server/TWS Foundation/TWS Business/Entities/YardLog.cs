using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;
using TWS_Business.Quality.Q_Depots.Q_Validators;

using BEntity = TWS_Business.Bases.BEntity;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] for <see cref="YardLog"/> entries. A <see cref="YardLog"/> record stores information about an entry or exit from the main business [Yards].
/// </summary>
public class YardLog
    : BEntity {

    #region Properties

    /// <summary>
    ///     Wheter the record is entry or exit.
    /// </summary>
    public bool Entry { get; set; }


    /// <summary>
    ///     Wheter the record is a reservation.
    /// </summary>
    public bool Reservation { get; set; }

    /// <summary>
    ///     <see cref="YardLog"/> record load seal.
    /// </summary>
    [StringLength(64, MinimumLength = 10)]
    public string? Seal { get; set; }

    /// <summary>
    ///     <see cref="YardLog"/> record load alternative seal.
    /// </summary>
    [StringLength(64, MinimumLength = 10)]
    public string? SealAlt { get; set; }

    /// <summary>
    ///     From where the trip started - where is going.
    /// </summary>
    [StringLength(100, MinimumLength = 10)]
    public string FromTo { get; set; } = string.Empty;

    /// <summary>
    ///     <see cref="YardLog"/> record evidence photo.
    /// </summary>
        // public byte[] Evidence { get; set; } = [];

    /// <summary>
    ///     <see cref="YardLog"/> damage evidence photo.
    /// </summary>
        // public byte[]? Damage { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Vehicules.LoadType"/> information.
    /// </summary>
    [Relation]
    public LoadType LoadType { get; set; } = default!;

    /// <summary>
    ///     <see cref="Employee"/> guard information.
    /// </summary>
    [Relation]
    public Employee Guard { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Section"/> information.
    /// </summary>
    [Relation]
    public Section Section { get; set; } = default!;

    /// <summary>
    ///     <see cref="Vehicules.Trucks.Truck_Common"/> information.
    /// </summary>

    [Relation, QualityTruckAdapterAttribute]
    public Truck_Common? Truck { get; set; }

    /// <summary>
    ///     <see cref="Vehicules.Trailers.Trailer_Common"/> information.
    /// </summary>

    [Relation, QualityTrailerAdapterAttribute]
    public Trailer_Common? Trailer { get; set; }

    /// <summary>
    ///     <see cref="Drivers.Driver_Common"/> information.
    /// </summary>

    [Relation, QualityDriverAdapterAttribute]
    public Driver_Common? Driver { get; set; }

    #endregion

    #region Dependents
    /// <summary>
    /// Collection of images resouces for <see cref="Truck"/>, <see cref="Trailer"/> and damages.
    /// </summary>
    [Relation]
    public ICollection<Resource> Resources { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Yard_Logs");

        etBuilder.Property(nameof(Seal)).HasMaxLength(64);
        etBuilder.Property(nameof(SealAlt)).HasMaxLength(64);
        etBuilder.Property(nameof(FromTo)).HasMaxLength(100).IsRequired();
        //etBuilder.Property(nameof(Evidence)).IsRequired();
        //etBuilder.Property(nameof(Damage));

        etBuilder.Link<YardLog, LoadType>(nameof(LoadType), Required: true);
        etBuilder.Link<YardLog, Employee>(nameof(Guard), Required: true);
        etBuilder.Link<YardLog, Section>(nameof(Section), Required: true);
        etBuilder.Link<YardLog, Driver_Common>(nameof(Driver), Required: true);
        etBuilder.Link<YardLog, Truck_Common>(nameof(Truck), Required: true);
        etBuilder.Link<YardLog, Trailer_Common>(nameof(Trailer));
    }
}
