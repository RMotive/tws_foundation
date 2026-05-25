using CSM_Database_Core.Core.Attributes;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

using BNamedEntity = TWS_Business.Bases.BNamedEntity;

namespace TWS_Business.Entities;

/// <summary>
///     {entity} class.
///     
///     Implements a <see cref="BNamedEntity"/> and <see cref="BEntity"/> to represent a {csm} business entity that stores
///     information about a system status for an specific entity.
/// </summary>
public class Status
    : CatalogEntity {

    #region Dependants

    /// <summary>
    ///     <see cref="VehiculeModel"/> dependants from this <see cref="Status"/>.
    /// </summary>
    [EntityDependency("Models", typeof(VehiculeModel), isCollection:true)]
    public ICollection<VehiculeModel> Models { get; set; } = [];

    /// <summary>
    ///     <see cref="Driver_Common"/> referencing to this <see cref="Status"/>.
    /// </summary>
    [EntityDependency("Drivers", typeof(Driver_Common), isCollection:true)]
    public ICollection<Driver_Common> Drivers { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck_Common"/> referencing to this <see cref="Status"/>.
    /// </summary>
    [EntityDependency("Trucks", typeof(Truck_Common), isCollection:true)]
    public ICollection<Truck_Common> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer_Common"/> referencing to this <see cref="Status"/>
    /// </summary>
    [EntityDependency("Trailers", typeof(Trailer_Common), isCollection:true)]
    public ICollection<Trailer_Common> Trailers { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer_Type"/> dependants from this <see cref="Status"/>.
    /// </summary>
    [EntityDependency("TrailerTypes", typeof(Trailer_Type), isCollection:true)]
    public ICollection<Trailer_Type> TrailerTypes { get; set; } = [];

    /// <summary>
    ///     <see cref="SCT"/> dependants from this <see cref="Status"/>
    /// </summary>
    [EntityDependency("SCTs", typeof(SCT), isCollection:true)]
    public ICollection<SCT> SCTs { get; set; } = [];

    /// <summary>
    ///     <see cref="Carrier_History"/> entries dependants from this <see cref="Status"/>.
    /// </summary>
    [EntityDependency("CarriersHistories", typeof(Carrier_History), isCollection:true)]
    public ICollection<Carrier_History> CarriersHistories { get; set; } = [];

    /// <summary>
    ///     <see cref="Approach_History"/> entries dependants from this <see cref="Status"/>.
    /// </summary>
    [EntityDependency("ApproachesHistories", typeof(Approach_History), isCollection:true)]
    public ICollection<Approach_History> ApproachesHistories { get; set; } = [];

    /// <summary>
    ///     <see cref="Insurance"/> dependants from this <see cref="Status"/>
    /// </summary>
    [EntityDependency("Insurances", typeof(Insurance), isCollection:true)]
    public ICollection<Insurance> Insurances { get; set; } = [];

    /// <summary>
    ///     <see cref="Insurance_History"/> dependants from this <see cref="Status"/>
    /// </summary>
    [EntityDependency("InsurancesHistories", typeof(Insurance_History), isCollection:true)]
    public ICollection<Insurance_History> InsurancesHistories { get; set; } = [];

    /// <summary>
    ///     <see cref="Maintenances.Maintenance"/> dependants from this <see cref="Status"/>
    /// </summary>
    [EntityDependency("Maintenances", typeof(Maintenances.Maintenance), isCollection:true)]
    public ICollection<Maintenances.Maintenance> Maintenances { get; set; } = [];

    /// <summary>
    ///     <see cref="Maintenances.Maintenance_History"/> dependants from this <see cref="Status"/>
    /// </summary>
    [EntityDependency("MaintenancesHistories", typeof(Maintenances.Maintenance_History), isCollection:true)]
    public ICollection<Maintenances.Maintenance_History> MaintenancesHistories { get; set; } = [];

    /// <summary>
    ///     <see cref="Plate"/> dependants from this <see cref="Status"/>.
    /// </summary>
    [EntityDependency("Plates", typeof(Plate), isCollection:true)]
    public ICollection<Plate> Plates { get; set; } = [];

    /// <summary>
    ///     <see cref="Plate_History"/> dependants from this <see cref="Status"/>.
    /// </summary>
    [EntityDependency("PlatesHistories", typeof(Plate_History), isCollection:true)]
    public ICollection<Plate_History> PlatesHistories { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Reference)).HasMaxLength(8).IsRequired().IsFixedLength();
        etBuilder.HasIndex(nameof(Reference)).IsUnique();

    }
}