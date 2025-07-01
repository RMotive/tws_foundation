namespace CSM_Foundation.Database.Models;

public record ConnectionOptions {
    public required string Host { get; init; }
    public required string Name { get; init; }
    public required string User { get; init; }
    public required string Password { get; init; }

    public bool Encrypt { get; init; } = false;

    public bool IntegratedSecurity { get; init; } = false;

    public bool Trust { get; init; } = false;

    public bool MARS { get; init; } = false;

    public string GenerateConnectionString() {
        string connectionString = $"Server={Host};Database={Name};";

        if(IntegratedSecurity) {
            connectionString += $"Integrated Security={IntegratedSecurity};";
        } else {
            connectionString += $"User={User};Password={Password};";
        }

        return connectionString + $"Encrypt={Encrypt};TrustServerCertificate={Trust};MultipleActiveResultSets={MARS};";
    }
}
