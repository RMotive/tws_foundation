﻿using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Axis
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public string Name { get; set; } = null!;

    public int Quantity { get; set; }

    public string? Description { get; set; }

    public virtual ICollection<TrailerClass> TrailerClasses { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
            ..Container,
            (nameof(Name), [new RequiredValidator(), new LengthValidator(Max: 30)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Axis>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Axes");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Name)
                .HasMaxLength(30)
                .IsUnicode(false);

            Entity.Property(e => e.Description)
                .HasMaxLength(100)
                .IsUnicode(false);
        });
    }
}
