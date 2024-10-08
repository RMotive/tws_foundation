﻿namespace CSM_Foundation.Database.Models.Options;
public class DatabasesLinkOptions {
    public required string Host { get; init; }
    public required string Name { get; init; }
    public required string User { get; init; }
    public required string Password { get; init; }
    public bool Encrypt { get; init; } = false;

    public bool Trust { get; init; } = false;

    public string GenerateConnectionString() {
        return $"Server={Host};" +
            $"Database={Name};" +
            $"User={User};" +
            $"Password={Password};" +
            $"Encrypt={Encrypt};" +
            $"TrustServerCertificate={Trust}";
    }
}
